import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/appConst/app_images.dart';
import 'controller/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});
  static const String routeName = "/SplashPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.imgLogo),
            Text(controller.initController),
          ],
        ),
      ),
    );
  }
}
