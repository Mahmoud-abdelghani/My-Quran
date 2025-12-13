import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  static StreamController<NotificationResponse> notifyStreamController =
      StreamController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static onTapNotification(NotificationResponse notificationResponse) {
    notifyStreamController.add(notificationResponse);
  }

  Future<void> initNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onTapNotification,
      onDidReceiveNotificationResponse: onTapNotification,
    );
  }

  Future<void> showBasicNotifications() async {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "id_B",
        "ss",
        priority: Priority.high,
        importance: Importance.high,
        sound: RawResourceAndroidNotificationSound(
          'download.wav'.split('.').first,
        ),
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      10,
      "الصلاة على النبى",
      "صلي على محمد",
      notificationDetails,
    );
  }

  Future<void> showSchadualedNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int min,
    required String payload,
    String? sound,
  }) async {
    try {
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          body,
          "schadueled",
          importance: Importance.max,
          priority: Priority.high,
          sound: sound != null
              ? RawResourceAndroidNotificationSound(sound)
              : null,
        ),
      );
      tz.initializeTimeZones();
      final TimezoneInfo currentTimeZone =
          await FlutterTimezone.getLocalTimezone();

      tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));
      final currentTime = tz.TZDateTime.now(tz.local);

      if (currentTime.isAfter(
        tz.TZDateTime(
          tz.local,
          currentTime.year,
          currentTime.month,
          currentTime.day,
          hour,
          min,
        ),
      )) {
        currentTime.add(Duration(days: 1));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime(
          tz.local,
          currentTime.year,
          currentTime.month,
          currentTime.day,
          hour,
          min,
        ),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload,
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> showPeriodicallyNotificaion() async {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "الصلاه على النبى",
        "periodiclly notification",
        sound: RawResourceAndroidNotificationSound(
          'download.wav'.split('.').first,
        ),
      ),
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      20,
      "الصلاه على النبى",
      "صلي على محمد",
      RepeatInterval.everyMinute,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  Future<void> cancelNotificationById(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
