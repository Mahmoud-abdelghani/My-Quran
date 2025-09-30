import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quran/core/utils/color_guid.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/location_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/nextpray_cubit.dart';
import 'package:quran/features/timedetails/cubit/fetchprayer_cubit.dart';
import 'package:quran/features/timedetails/presentation/pages/next_pray_details.dart';

class HeadScreen extends StatelessWidget {
  const HeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return BlocBuilder<NextprayCubit, NextprayState>(
      builder: (context, state) {
        if (state is NextprayLoading) {
          return Padding(
            padding: EdgeInsets.only(top: ScreenSize.hight * 0.03),
            child: Row(
              children: [
                SizedBox(
                  height: ScreenSize.hight * 0.15,
                  width: ScreenSize.width * 0.4,
                  child: Center(child: CircularProgressIndicator()),
                ),
                Image.asset(
                  "assets/images/image 4.png",
                  width: ScreenSize.width * 0.552,
                  height: ScreenSize.hight * 0.3,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          );
        } else if (state is NextpraySuccess) {
          return Padding(
            padding: EdgeInsets.only(top: ScreenSize.hight * 0.03),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Quran",
                      style: TextStyle(
                        color: ColorGuid.mainColor,
                        fontSize: ScreenSize.hight * 0.0365,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontsGuid.poppins,
                      ),
                    ),
                    Text(
                      "Read the Quran\nEasily",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: FontsGuid.poppins,
                        fontSize: ScreenSize.hight * 0.02,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      DateFormat('HH:mm').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontsGuid.poppins,
                        fontSize: ScreenSize.hight * 0.055,
                      ),
                    ),
                    Text(
                      '${context.read<NextprayCubit>().nextdayModel!.month},${context.read<NextprayCubit>().nextdayModel!.date.split('-')[1]}-${context.read<NextprayCubit>().nextdayModel!.date.split('-')[2]}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenSize.hight * 0.015,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontsGuid.poppins,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        BlocProvider.of<FetchprayerCubit>(context).getPrayers(
                          city: context
                              .read<LocationCubit>()
                              .loction
                              .toString(),
                          country: context
                              .read<LocationCubit>()
                              .address
                              .toString(),
                        );
                        Navigator.pushNamed(context, NextPrayDetails.routeName);
                      },
                      minWidth: ScreenSize.width * 0.3,
                      height: ScreenSize.hight * 0.05,
                      color: ColorGuid.mainColor,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(
                          ScreenSize.hight * 0.006,
                        ),
                      ),
                      child: Text(
                        context
                            .read<NextprayCubit>()
                            .nextdayModel!
                            .nextPray
                            .keys
                            .first,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsGuid.poppins,
                          fontSize: ScreenSize.hight * 0.025,
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  "assets/images/image 4.png",
                  width: ScreenSize.width * 0.552,
                  height: ScreenSize.hight * 0.3,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          );
        } else {
          return Text("error");
        }
      },
    );
  }
}
