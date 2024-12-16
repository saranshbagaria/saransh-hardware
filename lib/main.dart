import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_routes.dart';
import 'commonModule/commonControllers/connectivity.dart';
import 'commonModule/commonServices/hive/hive_store.dart';
import 'commonModule/commonServices/localization/localization_service.dart';
import 'modules/splash/splash_page.dart';
import 'utils/appConst/app_string.dart';
import 'utils/common/custom_logger.dart';

late SecureLogger logger;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  logger = SecureLogger();
  final hiveStore = HiveStore.instance;
  await hiveStore.initBox();
  //todo: open comments when need notification
  // NotificationServiceHelper notificationServiceHelper =
  //     NotificationServiceHelper();
  // await Firebase.initializeApp();
  // await notificationServiceHelper.handleNotificationPermission();
  // FirebaseMessaging.onBackgroundMessage(
  //     notificationServiceHelper.backgroundHandler);
  // LocalNotificationService.initialize();
  // notificationServiceHelper.handleNotification();

  String? savedLanguage = hiveStore.getString(HiveKeys.language);
  Locale initialLocale =
      LocalizationService.getLocaleFromLanguage(savedLanguage ?? 'English');
  Get.put(ConnectivityController());
  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialLocale});
  final Locale initialLocale;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConst.appName,
      translations: LocalizationService(),
      locale: initialLocale,
      fallbackLocale: LocalizationService.fallbackLocale,
      supportedLocales: LocalizationService.locales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        bool isRTL = LocalizationService()
            .isRTLLanguage(Get.locale?.languageCode ?? 'en');
        return Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
      getPages: AppRoutes.getPages,
      initialRoute: SplashPage.routeName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
