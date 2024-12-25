import 'package:flutter_testing/modules/coupon/controller/coupon_controller.dart';
import 'package:flutter_testing/modules/coupon/service/coupon_service.dart';
import 'package:get/get.dart';

class CouponBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ICouponService>(() => CouponService(),);
    Get.lazyPut<CouponController>(()=> CouponController(Get.find<ICouponService>()));
  }

}
