// // // Base Code Structure to follow :-
// //
// // import 'package:get/get_instance/src/bindings_interface.dart';
// //
// // class CoupoScanner implements Bindings {
// //   @override
// //   void dependencies() {
// //     // Register SignupService
// //     Get.lazyPut<ISignupService>(
// //       () => SignupService(),
// //     );
// //
// //     // Register SignupController
// //     Get.lazyPut<SignupController>(
// //       () => SignupController(Get.find<ISignupService>()),
// //     );
// //   }
// // }
// //
// import 'package:flutter/cupertino.dart';
//
// class CouponScannerPage extends StatelessWidget {
//
//
//   static const String routeName = "/couponScanner";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.transparent,
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 32),
//           width: double.infinity,
//         ),
//       ),
//     );
//   }
// }
//
// class SignupController extends GetxController {
//   final ISignupService _signupService;
//
//   SignupController(this._signupService);
// }
// //
// // abstract class ISignupService {}
// //
// // class SignupService implements ISignupService {}
