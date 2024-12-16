import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../commonModule/commonControllers/connectivity.dart';
import '../appConst/app_images.dart';
import '../reusableWidgets/reusable_button.dart';
import '../reusableWidgets/reusable_dialog.dart';

void showNoInternetDialog() {
  ConnectivityController controller = Get.find<ConnectivityController>();
  ReusableDialog.show(
    isDismissible: false,
    borderRadius: BorderRadius.circular(20),
    width: 335,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 30),
        Image.asset(
          AppImages.imgNoInternet,
          height: 50,
          width: 50,
        ),
        const SizedBox(height: 20),
        const Text(
          "No Internet !!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Please Check your Internet Connection",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        ReusableButton(
          textColor: Colors.white,
          width: 295,
          height: 55,
          radius: 10,
          title: "Retry",
          onTap: () async {
            controller.loadingCheckConnectivity.value = true;
            await controller.initConnectivity();
            controller.loadingCheckConnectivity.value = false;
          },
        ),
        const SizedBox(height: 30),
      ],
    ),
  );
}
