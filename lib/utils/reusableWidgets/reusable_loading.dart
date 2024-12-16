import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showCustomLoading({
  String message = "Loading...",
  bool isShowMessage = true,
}) async {
  Get.dialog(
    Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 120.0, vertical: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        // width: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CupertinoActivityIndicator(),
            Visibility(
              visible: isShowMessage,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Text(
                    message,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
    barrierDismissible: false,
    barrierColor: Colors.grey.withOpacity(.2),
  );
}

Future<void> hideCustomLoading() async {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}
