import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  String pickedPath = "";

  Future<String?> pickImageFromGallery({bool isCircle = true}) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (image == null) return null;

      File? imageTemp = File(image.path);
      imageTemp = await _cropImage(imagefile: imageTemp, isCricle: isCircle);
      pickedPath = imageTemp!.path;
      Get.back();
      return pickedPath;
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }

    update();
    return null;
  }

  Future<String?> pickImageFromCamera({bool isCircle = true}) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 70);
      if (image == null) return null;

      File? imageTemp = File(image.path);
      imageTemp = await _cropImage(imagefile: imageTemp, isCricle: isCircle);
      pickedPath = imageTemp!.path;
      Get.back();
      return pickedPath;
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
    update();
    return null;
  }

  Future _cropImage({required File imagefile, required bool isCricle}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imagefile.path,
      compressQuality: 20,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: const Color(0xff805FFE),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          cropStyle: isCricle ? CropStyle.circle : CropStyle.rectangle,
        ),
        IOSUiSettings(
          title: 'Cropper',
          cropStyle: isCricle ? CropStyle.circle : CropStyle.rectangle,
        ),
      ],
    );
    if (croppedImage == null) {
      return null;
    }
    return File(croppedImage.path);
  }
}
