// Base Code Structure to follow :-

// class SignupBinding implements Bindings {
//   @override
//   void dependencies() {
//     // Register SignupService
//     Get.lazyPut<ISignupService>(
//       () => SignupService(),
//     );

//     // Register SignupController
//     Get.lazyPut<SignupController>(
//       () => SignupController(Get.find<ISignupService>()),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_testing/modules/painter/service/painter_service.dart';
import 'package:get/get.dart';
import '../../utils/appConst/app_colors.dart';
import 'controller/painter_controller.dart';

class PainterPage extends GetView<PainterController> {
  const PainterPage({super.key});

  static const String routeName = "/createPainterPage";
  static IPainterService painterService = PainterService();
  static var painterController = PainterController(painterService);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Obx(
                  () =>
                  TextField(
                    controller: painterController.nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                      errorText: painterController.isNameValid.value
                          ? null
                          : "Name is required",
                    ),
                  ),
            ),
            SizedBox(
              height: 16,
            ),
            Obx(
                  () =>
                  TextField(
                    controller: painterController.contactController,
                    decoration: InputDecoration(
                      labelText: "Contact Number",
                      border: OutlineInputBorder(),
                      errorText: painterController.isContactValid.value
                          ? null
                          : "Contact Number is required",
                    ),
                  ),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: painterController.submitForm,
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}







