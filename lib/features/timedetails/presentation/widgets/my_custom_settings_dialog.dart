import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/cubit/theme_cubit.dart';
import 'package:quran/core/database/cache_helper.dart';
import 'package:quran/core/services/local_notification_service.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/timedetails/cubit/notification_memory_cubit.dart';

class MyCustomSettingsDialog extends StatefulWidget {
  const MyCustomSettingsDialog({super.key});

  @override
  State<MyCustomSettingsDialog> createState() => _MyCustomSettingsDialogState();
}

class _MyCustomSettingsDialogState extends State<MyCustomSettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          Image.asset('assets/images/Shape-07.png'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: ScreenSize.hight * 0.05,
              children: [
                Text(
                  'Settings',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: ScreenSize.hight * 0.035,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontsGuid.poppins,
                  ),
                ),
                Text(
                  "Themeing:",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: ScreenSize.hight * 0.024,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontsGuid.poppins,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Theme:',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: ScreenSize.hight * 0.022,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontsGuid.poppins,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<ThemeCubit>().toggleMode();
                      },
                      icon: BlocBuilder<ThemeCubit, ThemeMode>(
                        builder: (context, state) {
                          return Icon(
                            state == ThemeMode.light
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            color: Theme.of(context).primaryColorDark,
                            size: ScreenSize.hight * 0.04,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Text(
                  "Notifications:",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: ScreenSize.hight * 0.023,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontsGuid.poppins,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'الصَّلَاةُ عَلَى النَّبِيِّ:',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: ScreenSize.hight * 0.023,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontsGuid.poppins,
                      ),
                    ),
                    BlocBuilder<NotificationMemoryCubit, bool>(
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () async {
                            BlocProvider.of<NotificationMemoryCubit>(
                              context,
                            ).toggleNotifications();
                            if (!state) {
                              await LocalNotificationService()
                                  .cancelNotificationById(10);
                            }
                            await CacheHelper.storeString(
                              'avilable',
                              state.toString(),
                            );
                          },
                          child: Text(
                            state ? "إِيقَافٌ" : "تَشْغِيلٌ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: ScreenSize.hight * 0.023,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontsGuid.poppins,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
