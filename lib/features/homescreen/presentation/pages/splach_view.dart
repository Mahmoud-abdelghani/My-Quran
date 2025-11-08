import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quran/core/services/local_notification_service.dart';
import 'package:quran/core/services/work_manager_service.dart';
import 'package:quran/core/utils/color_guid.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/location_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/nextpray_cubit.dart';
import 'package:quran/features/homescreen/presentation/pages/home_view.dart';
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
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                children: [
                  Spacer(flex: 2),
                  Image.asset(
                    "assets/images/quran 1.png",
                    height: ScreenSize.hight * 0.3,
                    width: ScreenSize.width * 0.4,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "My Quran",
                    style: TextStyle(
                      fontFamily: FontsGuid.poppins,
                      fontSize: ScreenSize.hight * 0.055,
                      color: ColorGuid.mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Read the Quran Easily",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: FontsGuid.poppins,
                      fontSize: ScreenSize.hight * 0.03,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(flex: 3),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await insureNotificationsPermissions();
                        await LocalNotificationService().initNotifications();
                        await WorkManagerService.workManagerInitializetion();
                        await BlocProvider.of<LocationCubit>(
                          context,
                        ).getLocation();
                      } on Exception catch (e) {
                        // TODO
                        log(e.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorGuid.mainColor,
                      fixedSize: Size(
                        ScreenSize.width * 0.48,
                        ScreenSize.hight * 0.07,
                      ),
                    ),
                    child: Text(
                      "Read Now",
                      style: TextStyle(
                        fontSize: ScreenSize.hight * 0.02,
                        color: Colors.white,
                        fontFamily: FontsGuid.poppins,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, LocationState state) {
        if (state is LocationSuccess) {
          BlocProvider.of<NextprayCubit>(
            context,
          ).getTheNext(address: state.address);

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
