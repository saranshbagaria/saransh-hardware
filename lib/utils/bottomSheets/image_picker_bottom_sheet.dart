import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../commonModule/commonControllers/image_picker.dart';
import '../appConst/app_colors.dart';
import '../reusableWidgets/reusable_snackbar.dart';
import '../reusableWidgets/reusable_bottom_sheet.dart';

var imageController = Get.find<ImagePickerController>();

void showPickImageBottomSheet({
  required BuildContext context,
  required void Function(String selectedPath) setImagePath,
}) {
  ReusableBottomSheet.show(
    config: const BottomSheetConfig(
      backgroundColor: AppColors.white,
      borderRadius: 26.0,
      height: 200,
      showCloseButton: true,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          InkWell(
            onTap: () async {
              await imageController.pickImageFromCamera().then((value) async {
                if (value != null) {
                  setImagePath(value);
                  ReusableBottomSheet.close();
                } else {
                  showCustomSnackBar(
                    message: "Please Pick Image",
                    title: "Error",
                    color: AppColors.red,
                  );
                }
              });
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt_rounded,
                    size: 26,
                    color: Color(0xff5EBDE2),
                  ),
                  SizedBox(width: 28),
                  Text(
                    "Camera",
                    style: TextStyle(
                      color: Color(0xff444444),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Divider(
            color: Color(0xffE0E0E0),
            thickness: 1.5,
          ),
          const SizedBox(height: 14),
          InkWell(
            onTap: () async {
              await imageController.pickImageFromGallery().then((value) async {
                if (value != null) {
                  setImagePath(value);
                  ReusableBottomSheet.close();
                } else {
                  showCustomSnackBar(
                    message: "Please Pick Image",
                    title: "Error",
                    color: AppColors.red,
                  );
                }
              });
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.perm_media,
                    size: 26,
                    color: Color(0xff5EBDE2),
                  ),
                  SizedBox(width: 28),
                  Text(
                    "Upload from Gallery",
                    style: TextStyle(
                      color: Color(0xff444444),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
