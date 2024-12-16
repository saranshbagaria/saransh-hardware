import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReusableDialog extends StatelessWidget {
  final Widget child;
  final bool isDismissible;
  final Color? barrierColor;
  final BorderRadius? borderRadius;
  final EdgeInsets contentPadding;
  final Color? backgroundColor;
  final Widget? closeIcon;
  final VoidCallback? onClose;
  final double? height;
  final double? width;

  const ReusableDialog({
    super.key,
    required this.child,
    this.isDismissible = true,
    this.barrierColor,
    this.borderRadius,
    this.contentPadding = const EdgeInsets.all(16.0),
    this.backgroundColor,
    this.closeIcon,
    this.onClose,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isDismissible,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
        ),
        backgroundColor: backgroundColor,
        child: SizedBox(
          width: width ?? double.infinity,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                padding: contentPadding,
                width: double.infinity,
                height: height,
                child: height == null
                    ? child
                    : SingleChildScrollView(child: child),
              ),
              if (isDismissible)
                InkWell(
                  child: IconButton(
                    icon: closeIcon ?? const Icon(Icons.close, size: 20),
                    onPressed: () {
                      onClose?.call();
                      Get.back();
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<T?> show<T>({
    required Widget child,
    bool isDismissible = true,
    Color? barrierColor,
    BorderRadius? borderRadius,
    EdgeInsets contentPadding = const EdgeInsets.all(16.0),
    Color? backgroundColor,
    Widget? closeIcon,
    VoidCallback? onClose,
    double? height,
    double? width,
  }) {
    return Get.dialog<T>(
      ReusableDialog(
        isDismissible: isDismissible,
        barrierColor: barrierColor,
        borderRadius: borderRadius,
        contentPadding: contentPadding,
        backgroundColor: backgroundColor,
        closeIcon: closeIcon,
        onClose: onClose,
        height: height,
        width: width,
        child: child,
      ),
      barrierDismissible: isDismissible,
      barrierColor: barrierColor ?? Colors.black54,
    );
  }

  static void close<T>([T? result]) {
    if (Get.isDialogOpen ?? false) {
      Get.back<T>(result: result);
    }
  }
}
