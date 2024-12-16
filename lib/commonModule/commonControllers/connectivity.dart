import 'dart:async';
import 'dart:io';

import 'package:flutter_testing/utils/bottomSheets/no_internet_bottom_sheet.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../utils/dialogs/show_no_internet_connectivity_dialog.dart';
import '../../main.dart';

enum ConnectionStatus { online, offline }

enum ConnectionType { mobile, wifi, ethernet, vpn, bluetooth, other, none }

enum NoInternetDisplayType { dialog, bottomSheet }

class ConnectivityController extends GetxController {
  bool isNoInternetDisplayVisible = false;
  bool allowDisplay = true;
  final loadingCheckConnectivity = false.obs;
  final connectionStatus = ConnectionStatus.offline.obs;
  final NoInternetDisplayType displayType;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityController({
    this.displayType = NoInternetDisplayType.bottomSheet,
  });

  @override
  void onReady() {
    super.onReady();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      _updateConnectionStatus(result);
    });
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  Future<void> initConnectivity() async {
    try {
      final List<ConnectivityResult> result =
          await _connectivity.checkConnectivity();
      await _updateConnectionStatus(result);
    } catch (e) {
      connectionStatus.value = ConnectionStatus.offline;
      _showNoInternetDisplay();
      logger.error(e);
    }
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.none)) {
      connectionStatus.value = ConnectionStatus.offline;
      _showNoInternetDisplay();
    } else {
      await _checkInternetConnection();
    }
  }

  Future<void> _checkInternetConnection() async {
    loadingCheckConnectivity.value = true;
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectionStatus.value = ConnectionStatus.online;
        if (isNoInternetDisplayVisible) {
          Get.back();
          isNoInternetDisplayVisible = false;
        }
      } else {
        _showNoInternetDisplay();
      }
    } on SocketException catch (_) {
      _showNoInternetDisplay();
    } on TimeoutException catch (_) {
      _showNoInternetDisplay();
    } finally {
      loadingCheckConnectivity.value = false;
    }
  }

  void _showNoInternetDisplay() {
    connectionStatus.value = ConnectionStatus.offline;
    if (!isNoInternetDisplayVisible && allowDisplay) {
      isNoInternetDisplayVisible = true;

      void onRetry() async {
        loadingCheckConnectivity.value = true;
        await initConnectivity();
        loadingCheckConnectivity.value = false;
      }

      void onDismiss() {
        if (displayType == NoInternetDisplayType.bottomSheet) {
          allowDisplay = false;
          Get.back();
          isNoInternetDisplayVisible = false;
        }
      }

      switch (displayType) {
        case NoInternetDisplayType.dialog:
          showNoInternetDialog();
          break;
        case NoInternetDisplayType.bottomSheet:
          NoInternetBottomSheet.show(onRetry: onRetry, onDismiss: onDismiss)
              .then((_) {
            isNoInternetDisplayVisible = false;
          });
          break;
      }
    }
  }

  void enableDisplay() {
    allowDisplay = true;
  }
}
