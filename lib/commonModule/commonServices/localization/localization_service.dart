import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../hive/hive_store.dart';
import 'translation/ar_sa.dart';
import 'translation/en_us.dart';
import 'translation/fr_fr.dart';
import 'translation/hi_in.dart';
import 'translation/ko_kr.dart';

class LocalizationService extends Translations {
// Default Locale
  static const locale = Locale('en', 'US');

  // Fallback locale
  static const fallbackLocale = Locale('en', 'US');

  // Supported languages
  static final languages = ['English', '한국어', 'Français', 'हिन्दी', 'العربية'];

  // Supported locales
  static final locales = [
    const Locale('en', 'US'),
    const Locale('ko', 'KR'),
    const Locale('fr', 'FR'),
    const Locale('hi', 'IN'),
    const Locale('ar', 'SA'),
  ];

  // Keys and their translations
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'fr_FR': frFR,
        'ko_KR': koKR,
        'hi_IN': hiIN,
        'ar_SA': arSA,
      };

  // Load initial locale from saved preferences
  static Locale getLocaleFromLanguage(String language) {
    for (int i = 0; i < languages.length; i++) {
      if (language == languages[i]) return locales[i];
    }
    return locale; // default to English
  }

  // Change and persist the locale
  void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    Get.updateLocale(locale);

    // Persist language to Hive
    HiveStore.instance.setString(HiveKeys.language, lang);
  }

  bool isRTLLanguage(String languageCode) {
    return ['ar', 'he', 'fa', 'ur'].contains(languageCode);
  }
}
