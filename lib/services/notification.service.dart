import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/notification.dart';

import 'local_storage.service.dart';

class NotificationService {

  static initializeAwesomeNotification() async {
    await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/notification_icon',
      [
        appNotificationChannel(),
      ],
    );
    //requet notifcation permission if not allowed
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  static NotificationChannel appNotificationChannel() {
    return NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for app',
      defaultColor: AppColor.primaryColor,
      ledColor: AppColor.primaryColor,
      importance: NotificationImportance.High,
      soundSource: "resource://raw/alert",
      playSound: true,
    );
  }
  
  //
  static Future<List<NotificationModel>> getNotifications() async {
    //
    final notificationsStringList = (await LocalStorageService.getPrefs()).getString(
      AppStrings.notificationsKey,
    );

    if (notificationsStringList == null) {
      return [];
    }

    return (jsonDecode(notificationsStringList) as List)
        .asMap()
        .entries
        .map((notificationObject) {
      //
      return NotificationModel(
        index: notificationObject.key,
        title: notificationObject.value["title"],
        body: notificationObject.value["body"],
        timeStamp: notificationObject.value["timeStamp"],
      );
    }).toList();
  }

  static void addNotification(NotificationModel notification) async {
    //
    final notifications = await getNotifications() ?? [];
    notifications.insert(0,notification);

    //
    await LocalStorageService.prefs.setString(
      AppStrings.notificationsKey,
      jsonEncode(notifications),
    );
  }

  static void updateNotification(NotificationModel notificationModel) async {
    //
    final notifications = await getNotifications();
    notifications.removeAt(notificationModel.index);
    notifications.insert(notificationModel.index, notificationModel);
    await LocalStorageService.prefs.setString(
      AppStrings.notificationsKey,
      jsonEncode(notifications),
    );
  }
}
