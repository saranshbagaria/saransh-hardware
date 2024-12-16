import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../appConst/app_colors.dart';


class ReusableBackButton extends StatelessWidget {
  const ReusableBackButton({
    super.key,
    this.borderColor,
    this.iconColor,
  });

  final Color? borderColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Navigator.canPop(context),
      child: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor ?? AppColors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
                child: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: iconColor,
            )),
          )),
    );
  }
}
