import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../appConst/app_colors.dart';
import '../reusableWidgets/reusable_snackbar.dart';

class CommonMethods {
  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> launchYourUrl({required String url}) async {
    //Todo : if you are using this please add this in your manifest file-
    // <queries>
    // <intent>
    // <action android:name="android.intent.action.VIEW" />
    // <category android:name="android.intent.category.BROWSABLE" />
    // <data android:scheme="https" />
    // </intent>
    // </queries>

    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showCustomSnackBar(
          message: "Enable to launch url",
          title: "Error",
          color: AppColors.red);
    }
  }

  Future<void> redirectPhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> redirectSMS(String phoneNumber) async {
    try {
      if (Platform.isAndroid) {
        String uri =
            'sms:$phoneNumber?body=${Uri.encodeComponent("Hello there")}';
        await launchUrl(Uri.parse(uri));
      } else if (Platform.isIOS) {
        String uri =
            'sms:$phoneNumber&body=${Uri.encodeComponent("Hello there")}';
        await launchUrl(Uri.parse(uri));
      }
    } catch (e) {
      showCustomSnackBar(
          message: "Some error occurred. Please try again!",
          title: "Error",
          color: AppColors.red);
    }
  }
}
