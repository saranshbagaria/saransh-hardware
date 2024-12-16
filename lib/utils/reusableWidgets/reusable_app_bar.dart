import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

AppBar reusableAppBar({
  required BuildContext context,
  required String title,
  bool centerTitle = true,
  List<Widget>? actions,
  double? elevation,
  Color? backgroundColor,
  Color? foregroundColor,
  TextStyle? titleTextStyle,
  double? toolbarHeight,
  Widget? leading,
  PreferredSizeWidget? bottom,
  bool automaticallyImplyLeading = true,
  double? leadingWidth,
  Widget? flexibleSpace,
  SystemUiOverlayStyle? systemOverlayStyle,
  IconThemeData? iconTheme,
  bool? primary = true,
  Size? preferredSize,
  VoidCallback? onBackPressed,
  IconData backIcon = Icons.arrow_back_ios,
  double backIconSize = 20,
  Color? backIconColor,
  double? titleSpacing,
  String? tooltip,
}) {
  return AppBar(
    title: Text(title),
    centerTitle: centerTitle,
    elevation: elevation,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    titleTextStyle: titleTextStyle,
    toolbarHeight: toolbarHeight,
    bottom: bottom,
    automaticallyImplyLeading: automaticallyImplyLeading,
    leadingWidth: leadingWidth,
    flexibleSpace: flexibleSpace,
    scrolledUnderElevation: 0.0,
    systemOverlayStyle: systemOverlayStyle,
    iconTheme: iconTheme,
    titleSpacing: titleSpacing,
    leading: leading ??
        (ModalRoute.of(context)!.canPop && automaticallyImplyLeading
            ? IconButton(
                onPressed: onBackPressed ?? () => Get.back(),
                icon: Icon(
                  backIcon,
                  size: backIconSize,
                  color: backIconColor,
                ),
                tooltip: tooltip ??
                    MaterialLocalizations.of(context).backButtonTooltip,
              )
            : null),
    actions: actions,
  );
}
