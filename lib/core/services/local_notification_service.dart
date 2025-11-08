import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static onTapNotification(NotificationResponse notificationResponse) {}
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
    String? sound
  }) async {
    try {
      log('update alert');
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "id_s",
          "schadueled",
          importance: Importance.max,
          priority: Priority.high,
          sound:sound!=null? RawResourceAndroidNotificationSound(
            sound
          ):null,
        ),
      );
      tz.initializeTimeZones();
      final TimezoneInfo currentTimeZone =
          await FlutterTimezone.getLocalTimezone();
      log(currentTimeZone.identifier);
      tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));
      final currentTime = tz.TZDateTime.now(tz.local);
      log(currentTime.toString());
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
      log(currentTime.toString());

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
