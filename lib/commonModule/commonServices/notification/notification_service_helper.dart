// import 'package:flutter_testing/commonModule/commonServices/notification/local_notification_service.dart';
// import 'package:flutter_testing/main.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class NotificationServiceHelper {
//   @pragma('vm:entry-point')
//   Future<void> backgroundHandler(RemoteMessage message) async {
//     logger.debug("background handler called");
//     LocalNotificationService.handleNotificationNavigation(
//         routeName: message.data["screenName"] ?? "",
//         id: message.data["id"] ?? "");
//   }
//
//   Future<void> handleNotificationPermission() async {
//     const permission = Permission.notification;
//     final status = await permission.status;
//     if (status.isGranted) {
//       logger.debug('User granted this permission before');
//     } else {
//       final before = await permission.shouldShowRequestRationale;
//       final rs = await permission.request();
//       final after = await permission.shouldShowRequestRationale;
//
//       if (rs.isGranted) {
//         logger.debug('User granted notication permission');
//       } else if (!before && after) {
//         logger
//             .debug('Show permission request pop-up and user denied first time');
//       } else if (before && !after) {
//         logger.debug(
//             'Show permission request pop-up and user denied a second time');
//       } else if (!before && !after) {
//         logger.debug('No more permission pop-ups displayed');
//       }
//     }
//   }
//
//   void handleNotification() {
//     // 1. This method call when app in terminated state and you get a notification
//     FirebaseMessaging.instance.getInitialMessage().then(
//       (message) {
//         if (message?.notification != null) {
//           LocalNotificationService.handleNotificationNavigation(
//               routeName: message?.data["screenName"] ?? "",
//               id: message?.data["id"] ?? "");
//         }
//       },
//     );
//
//     // 2. This method only call when App in forground it mean app must be opened
//     FirebaseMessaging.onMessage.listen(
//       (message) {
//         logger.debug("FirebaseMessaging.onMessage.listen");
//         logger.debug(message.data.toString());
//         if (message.notification != null) {
//           LocalNotificationService.createAndDisplayNotification(message);
//         }
//       },
//     );
//
//     // 3. This method only call wh  en App in background and not terminated(not closed)
//     FirebaseMessaging.onMessageOpenedApp.listen(
//       (message) {
//         logger.debug(
//             "FirebaseMessaging.onMessageOpenedApp.listen app was in background");
//         if (message.notification != null) {
//           LocalNotificationService.handleNotificationNavigation(
//               routeName: message.data["screenName"], id: message.data["id"]);
//         }
//       },
//     );
//   }
// }
