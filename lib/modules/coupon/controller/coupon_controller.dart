import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../service/coupon_service.dart';

class CouponController extends GetxController{

  final ICouponService _couponService;

  CouponController(this._couponService);

  var painterId = ''.obs;
  var painterName = ''.obs;
  var painterContactNumber = ''.obs;
  var qrCode = ''.obs;
  var pointController = TextEditingController();

  var isQrCodeValid = true.obs;
  var isPointsValid = true.obs;

  Future<void> submitCoupon()async {
    if(painterId.isEmpty){
      Get.snackbar('Error', 'painter is not available');
    }
    if(qrCode.isEmpty){
      Get.snackbar('Error', 'QR Code is Empty');
      isQrCodeValid.value = false;
    }
    if(pointController.text.trim().isEmpty ||  int.tryParse(pointController.text)! < 1){
      isPointsValid.value = false;
    }
    if(isPointsValid.value && isQrCodeValid.value){
      try {
            await _couponService.postCouponData(
            painterId: painterId.value,
            qrCode: qrCode.value,
            points: int.tryParse(pointController.text) ?? 0);
      }catch(error){
        Get.snackbar('Error', 'could not post coupon data');
      }
      Get.snackbar('Success', 'coupon created successfully');
    }
  }
}