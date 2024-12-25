import 'package:flutter/cupertino.dart';
import 'package:flutter_testing/modules/painter/service/painter_list_response.dart';
import 'package:get/get.dart';
import '../service/painter_service.dart';

class PainterController extends GetxController {
  final IPainterService _painterService;

  PainterController(this._painterService);

  final nameController = TextEditingController();

  final contactController = TextEditingController();

  var isNameValid = true.obs;

  var isContactValid = true.obs;

  Future<void> submitForm() async {
    if (nameController.text.trim().isEmpty) {
      isNameValid.value = false;
    } else {
      isNameValid.value = true;
    }

    if (contactController.text.trim().isEmpty ||
        !RegExp(r'^[-2-9]+$').hasMatch(contactController.text)) {
      isContactValid.value = false;
    } else {
      isContactValid.value = true;
    }

    if (isNameValid.value && isContactValid.value) {
      var response = await _painterService.sendPainterData(
        Painter(nameController.text, contactController.text),
      );

      response
          ? Get.snackbar(
        'Form Submitted',
        'Name: ${nameController.text}, Contact: ${contactController.text}',
        snackPosition: SnackPosition.BOTTOM,
      )
          : Get.snackbar('Error', 'got some error');
    }
  }
}


