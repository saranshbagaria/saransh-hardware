import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/reusableWidgets/reusable_app_bar.dart';
import 'controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  static const String routeName = "/HomePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar(
        context: context,
        title: 'hello'.tr,
        actions: [
          // DropdownButton<String>(
          //   value: LocalizationService.languages.firstWhere(
          //     (lang) =>
          //         LocalizationService.getLocaleFromLanguage(
          //                 Get.locale?.languageCode ?? 'en')
          //             .toString() ==
          //         lang,
          //     orElse: () => 'English',
          //   ),
          //   icon: const Icon(Icons.language),
          //   onChanged: (String? newLang) {
          //     if (newLang != null) {
          //       LocalizationService().changeLocale(newLang);
          //     }
          //   },
          //   items: LocalizationService.languages.map((String lang) {
          //     return DropdownMenuItem<String>(
          //       value: lang,
          //       child: Text(lang),
          //     );
          //   }).toList(),
          // ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
       
          ],
        ),
      ),
    );
  }
}
