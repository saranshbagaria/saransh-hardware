import 'package:flutter_testing/modules/coupon/binding/coupon_binding.dart';
import 'package:flutter_testing/modules/coupon/coupon_page.dart';
import 'package:flutter_testing/modules/painter/binding/painter_binding.dart';
import 'package:flutter_testing/modules/painter/binding/painter_list_binding.dart';
import 'package:flutter_testing/modules/painter/painter_list_page.dart';
import 'package:flutter_testing/modules/painter/painter_page.dart';
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
    GetPage(
      name: PainterListPage.routeName,
      page: () => const PainterListPage(),
      binding: PainterListBinding(),
    ),
    GetPage(
      name: PainterPage.routeName,
      page: () => const PainterPage(),
      binding: PainterBinding(),
    ),
    GetPage(
      name: CouponPage.routeName,
      page: () => const CouponPage(),
      binding: CouponBinding(),
    )
  ];
}
