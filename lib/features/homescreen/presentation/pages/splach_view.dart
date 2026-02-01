import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quran/core/database/cache_helper.dart';
import 'package:quran/core/services/local_notification_service.dart';
import 'package:quran/core/services/work_manager_service.dart';
import 'package:quran/core/utils/color_guid.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/location_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/nextpray_cubit.dart';
import 'package:quran/features/homescreen/presentation/pages/home_view.dart';
import 'package:quran/features/timedetails/cubit/notification_memory_cubit.dart';
import 'package:quran/main.dart';

class SplachView extends StatefulWidget {
  const SplachView({super.key});
  static const String routeName = "splachView";

  @override
  State<SplachView> createState() => _SplachViewState();
}

class _SplachViewState extends State<SplachView> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return BlocConsumer<LocationCubit, LocationState>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LocationLoading,
          progressIndicator: CircularProgressIndicator(
            color: ColorGuid.mainColor,
          ),
          child: Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/images/Shape-07.png',
                    height: ScreenSize.hight * 0.45,
                    width: ScreenSize.width * 0.5,

                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: ScreenSize.hight * 0.25,
                  child: Image.asset(
                    'assets/images/Shape-04.png',
                    width: ScreenSize.width * 0.55,
                    height: ScreenSize.hight * 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
                Image.asset(
                  'assets/images/Mosque-01.png',
                  width: ScreenSize.width,
                  height: ScreenSize.hight * 0.3,
                  fit: BoxFit.cover,
                ),
                Center(
                  child: Column(
                    children: [
                      Spacer(flex: 2),
                      Image.asset(
                        "assets/images/quran 1.png",
                        height: ScreenSize.hight * 0.3,
                        width: ScreenSize.width * 0.4,
                        fit: BoxFit.cover,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'My',
                              style: TextStyle(
                                fontFamily: FontsGuid.poppins,
                                fontSize: ScreenSize.hight * 0.06,
                                color: Color(0xffbfa27e),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' Quran',
                              style: TextStyle(
                                fontFamily: FontsGuid.poppins,
                                fontSize: ScreenSize.hight * 0.055,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        "Read the Quran Easily",
                        style: TextStyle(
                          color: Theme.of(context).splashColor,
                          fontFamily: FontsGuid.poppins,
                          fontSize: ScreenSize.hight * 0.03,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(flex: 3),
                      BlocBuilder<NotificationMemoryCubit, bool>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () async {
                              try {
                                await CacheHelper.storeString(
                                  'avilable',
                                  state.toString(),
                                );
                                await insureNotificationsPermissions();
                                await LocalNotificationService()
                                    .initNotifications();
                                await WorkManagerService.workManagerInitializetion();
                                if (!mounted) return;
                                await BlocProvider.of<LocationCubit>(
                                  // ignore: use_build_context_synchronously
                                  context,
                                ).getLocation();
                              } on Exception catch (e) {
                                log(e.toString());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                ScreenSize.width * 0.48,
                                ScreenSize.hight * 0.07,
                              ),
                            ),
                            child: Text(
                              "Read Now",
                              style: TextStyle(
                                fontSize: ScreenSize.hight * 0.02,
                                color: Theme.of(context).primaryColorLight,
                                fontFamily: FontsGuid.poppins,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, LocationState state) {
        if (state is LocationSuccess) {
          BlocProvider.of<NextprayCubit>(
            context,
          ).getTheNext(address: state.address, zone: state.zone);
          Navigator.pushReplacementNamed(context, HomeView.routeName);
        } else if (state is LocationError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("collecting your location")));
          openAppSettings();
        }
      },
    );
  }
}
