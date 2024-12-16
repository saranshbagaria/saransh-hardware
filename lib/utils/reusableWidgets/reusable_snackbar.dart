import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> closeAllCustomSnackBar() async {
  Get.closeAllSnackbars();
}

GetSnackBar showCustomSnackBar({
  String title = 'Success',
  required String message,
  Color color = Colors.green,
  Color backgroundColor = Colors.black,
  SnackPosition snackPosition = SnackPosition.BOTTOM,
  DismissDirection dismissDirection = DismissDirection.horizontal,
  EdgeInsets margin = const EdgeInsets.all(20),
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
  IconData icon = Icons.check_circle_outline,
  Duration duration = const Duration(seconds: 5),
  double borderRadius = 8.0,
}) {
  Get.log("[$title] $message");
  return GetSnackBar(
    titleText: Text(title,
        style: Get.textTheme.titleLarge!.merge(TextStyle(color: color))),
    messageText: Text(message,
        style: Get.textTheme.bodySmall!.merge(TextStyle(color: color))),
    snackPosition: snackPosition,
    margin: margin,
    backgroundColor: backgroundColor,
    icon: Icon(icon, size: 32, color: color),
    padding: padding,
    borderRadius: borderRadius,
    dismissDirection: dismissDirection,
    duration: duration,
  );
}
