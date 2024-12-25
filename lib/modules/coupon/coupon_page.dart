// Base Code Structure to follow :-
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/utils/reusableWidgets/reusable_app_bar.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'controller/coupon_controller.dart';

class CouponPage extends GetView<CouponController> {
  const CouponPage({super.key});

  static const String routeName = "/couponPage";

  // static final CouponService couponService = CouponService();
  // static CouponController couponController = CouponController(couponService);
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar(context: context, title: 'Register Coupon'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: IconButton(
              onPressed: () async {
                // TODO: add qr code page here
                final result = await Get.to(() => QRScannerView());
                controller.qrCode.value = result;
              },
              icon: Icon(Icons.qr_code_scanner,size: 25,),
            ),
          ),
          Obx(() =>
              Text(
                "Scanner value: ${controller.qrCode.value}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 20),
          TextField(
            controller: controller.pointController,
            decoration: InputDecoration(
              labelText: 'Enter Points',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              controller.pointController.text = value;
            },
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              controller.submitCoupon();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class QRScannerView extends StatelessWidget {
  const QRScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (barcode) {
        // final String? code = barcode.barcodes[0].rawValue;
        for (final barcode in barcode.barcodes) {
            if (barcode.rawValue != null) {
              Get.back(result: barcode.rawValue);// Use the controller
              break;
            }
        }
      },
      onDetectError: (error,stackTrace) {
        Get.snackbar('Error', error.toString());
      },
    );
  }
}

// class SignupService implements ISignupService {}
