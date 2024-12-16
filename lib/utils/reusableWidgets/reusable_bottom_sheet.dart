import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReusableBottomSheet {
  static bool _isBottomSheetOpen = false;
  static final RxBool isVisible = false.obs;

  static Future<T?> show<T>({
    required Widget child,
    BottomSheetConfig? config,
  }) async {
    if (_isBottomSheetOpen) return null;

    final effectiveConfig = config ?? const BottomSheetConfig();
    _isBottomSheetOpen = true;
    isVisible.value = true;

    Widget content = Container(
      height: effectiveConfig.height,
      constraints: effectiveConfig.constraints,
      decoration: BoxDecoration(
        color: effectiveConfig.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(effectiveConfig.borderRadius),
          topRight: Radius.circular(effectiveConfig.borderRadius),
        ),
      ),
      child: effectiveConfig.showCloseButton
          ? Stack(
              children: [
                child,
                Positioned(
                  right: 0,
                  top: 0,
                  child: Padding(
                    padding: effectiveConfig.closeButtonPadding,
                    child: GestureDetector(
                      onTap: close,
                      behavior: HitTestBehavior.opaque,
                      child: Icon(
                        effectiveConfig.closeIcon,
                        color: effectiveConfig.closeButtonColor,
                        size: effectiveConfig.closeButtonSize,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : child,
    );

    if (effectiveConfig.enableKeyboardResize) {
      content = Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: content,
      );
    }

    if (effectiveConfig.useSafeArea) {
      content = SafeArea(child: content);
    }

    return await Get.bottomSheet(
      content,
      isDismissible: effectiveConfig.isDismissible,
      enableDrag: effectiveConfig.enableDrag,
      barrierColor: effectiveConfig.barrierColor,
      isScrollControlled: true,
      enterBottomSheetDuration: effectiveConfig.animationDuration,
      exitBottomSheetDuration: effectiveConfig.animationDuration,
    ).whenComplete(() {
      _isBottomSheetOpen = false;
      isVisible.value = false;
    });
  }

  static void close() {
    if (_isBottomSheetOpen) {
      Get.back();
    }
  }

  static bool get isOpen => _isBottomSheetOpen;
}

class BottomSheetConfig {
  final double? height;
  final bool isDismissible;
  final bool enableDrag;
  final Color backgroundColor;
  final double borderRadius;
  final Color barrierColor;
  final Duration animationDuration;
  final bool enableKeyboardResize;
  final bool useSafeArea;
  final BoxConstraints? constraints;
  
  // Close button configurations
  final bool showCloseButton;
  final Color closeButtonColor;
  final double closeButtonSize;
  final EdgeInsets closeButtonPadding;
  final IconData closeIcon;

  const BottomSheetConfig({
    this.height,
    this.isDismissible = true,
    this.enableDrag = true,
    this.backgroundColor = Colors.white,
    this.borderRadius = 16.0,
    this.barrierColor = Colors.black54,
    this.animationDuration = const Duration(milliseconds: 300),
    this.enableKeyboardResize = true,
    this.useSafeArea = true,
    this.constraints,
    
    // Default close button configurations
    this.showCloseButton = false,
    this.closeButtonColor = Colors.black54,
    this.closeButtonSize = 24.0,
    this.closeButtonPadding = const EdgeInsets.all(16.0),
    this.closeIcon = Icons.close,
  });
}

