import 'package:get/get.dart';

import '../service/splash_service.dart';

class SplashController extends GetxController {
  SplashService splashService = SplashService();
  String initController = "";

  @override
  void onInit() {
    super.onInit();
    splashService.goToNextScreen();
  }
}
