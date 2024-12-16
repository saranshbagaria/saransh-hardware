import 'package:get/get.dart';

import '../../home/home_page.dart';
import 'i_splash_service.dart';

class SplashService implements ISplashService {
  @override
  void goToNextScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(HomePage.routeName);
    });
  }
}
