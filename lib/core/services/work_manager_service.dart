import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:quran/core/api/api_concumer.dart';
import 'package:quran/core/api/dio_concumer.dart';
import 'package:quran/core/api/end_points.dart';
import 'package:quran/core/database/cache_helper.dart';
import 'package:quran/core/errors/server_exception.dart';
import 'package:quran/core/services/local_notification_service.dart';
import 'package:quran/features/homescreen/data/models/nextday_model.dart';
import 'package:quran/features/timedetails/presentation/pages/next_pray_details.dart';
import 'package:timezone/timezone.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  static workManagerInitializetion() {
    Workmanager().initialize(callbackDispatcher);
    registerTasks();
    log('donees');
    log("callbackDispatcher started");
  }

  static void registerTasks() {
    try {
      Workmanager().registerPeriodicTask(
        'azkr_El_sabah',
        'azkr_El_sabah',
        frequency: Duration(hours: 6),
      );
      Workmanager().registerPeriodicTask(
        "azkar_El_Massa",
        "azkar_El_Massa",
        frequency: Duration(hours: 6, minutes: 5),
      );
      Workmanager().registerPeriodicTask(
        "El_salah_ala_El_nabi",
        "El_salah_ala_El_nabi",
        frequency: Duration(hours: 1),
      );
      Workmanager().registerPeriodicTask(
        "El_salah",
        "El_salah",
        inputData: {
          'address': CacheHelper.getString('Location') == "مصر"
              ? "egypt"
              : CacheHelper.getString('Location'),

          'Fajr': 'اقْتَرَبَتْ صَلَاةُ الْفَجْرِ',
          'Dhuhr': 'اقْتَرَبَتْ صَلَاةُ الظُّهْرِ',
          'Asr': 'اقْتَرَبَتْ صَلَاةُ الْعَصْرِ',
          'Maghrib': 'اقْتَرَبَتْ صَلَاةُ الْمَغْرِبِ',
          'Isha': 'اقْتَرَبَتْ صَلَاةُ الْعِشَاءِ',
        },
        frequency: Duration(minutes: 20),
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  log("callbackDispatcher started");
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case 'azkr_El_sabah':
        {
          WidgetsFlutterBinding.ensureInitialized();
          await LocalNotificationService().cancelNotificationById(1);
          await LocalNotificationService().showSchadualedNotification(
            id: 1,
            title: "لا تنسي اذكار الصباح",
            body: "لا تنسي اذكار الصباح",
            hour: 9,
            min: 0,
            sound: null,
          );
          break;
        }
      case 'azkar_El_Massa':
        {
          await LocalNotificationService().cancelNotificationById(2);
          await LocalNotificationService().showSchadualedNotification(
            id: 2,
            title: "لا تنسي اذكار المساء",
            body: "لا تنسي اذكار المساء",
            hour: 17,
            min: 0,
          );
          break;
        }
      case "El_salah_ala_El_nabi":
        {
          await LocalNotificationService().showBasicNotifications();
          break;
        }
      case "El_salah":
        {
          WidgetsFlutterBinding.ensureInitialized();
          log("taskName = $taskName");
          try {
            LocalNotificationService().cancelNotificationById(5);
            String address = inputData!['address'] ?? "egypt";
            ApiConcumer api = DioConcumer(
              baseUrl: EndPoints.baseUrlTimes,
              dio: Dio(),
            );
            final json = await api.get(
              '${DateFormat('yy-MM-dd').format(DateTime.now())}?address=$address&method=5&timezonestring=Africa/Cairo',
            );
            NextdayModel? nextdayModel = NextdayModel.fromJson(json);
            int hours = int.parse(
              nextdayModel.nextPray.values.first.toString().split(':').first,
            );
            int min = int.parse(
              nextdayModel.nextPray.values.first.toString().split(':').last,
            );
            

            if (min >= 5) {
              min -= 5;
            } else {
              hours--;
              min = 60 +min-5;
            }

            log("min: $min, hours : $hours");
            log(
              'body : ${inputData[nextdayModel.nextPray.keys.first]}, sound: ${nextdayModel.nextPray.keys.first.toLowerCase()}',
            );

            await LocalNotificationService().showSchadualedNotification(
              id: 5,
              title: "تنبيه الصلاة",
              body: inputData[nextdayModel.nextPray.keys.first],
              hour: hours,
              min: min,
              sound: nextdayModel.nextPray.keys.first.toLowerCase(),
            );
            log('donees');
          } on ServerException catch (e) {
            log(e.toString());
          }
          break;
        }
      default:
        {
          break;
        }
    }
    return Future.value(true);
  });
}
