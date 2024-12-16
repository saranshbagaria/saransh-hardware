import 'package:get/get.dart';
import 'modules/home/binding/home_binding.dart';
import 'modules/home/home_page.dart';
import 'modules/splash/binding/splash_binding.dart';
import 'modules/splash/splash_page.dart';

class AppRoutes {
  static List<GetPage> getPages = [
    GetPage(
      name: SplashPage.routeName,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: HomePage.routeName,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
