import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/color_guid.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/location_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/nextpray_cubit.dart';
import 'package:quran/features/homescreen/presentation/pages/home_view.dart';

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
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              children: [
                SizedBox(height: ScreenSize.hight * 0.2),
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
                SizedBox(height: ScreenSize.hight * 0.24),
                ElevatedButton(
                  onPressed: () {
                    if (state is LocationSuccess) {
                      BlocProvider.of<NextprayCubit>(
                        context,
                      ).getTheNext(address: state.address);
                      Navigator.pushReplacementNamed(
                        context,
                        HomeView.routeName,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("collecting your location")),
                      );
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
                      fontSize: ScreenSize.hight * 0.03,
                      color: Colors.white,
                      fontFamily: FontsGuid.poppins,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: ScreenSize.hight * 0.06),
              ],
            ),
          ),
        );
      },
    );
  }
}
