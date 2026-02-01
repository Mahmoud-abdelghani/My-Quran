import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/location_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/nextpray_cubit.dart';
import 'package:quran/features/timedetails/cubit/fetchprayer_cubit.dart';
import 'package:quran/features/timedetails/presentation/pages/next_pray_details.dart';

class HeadScreen extends StatefulWidget {
  const HeadScreen({super.key});

  @override
  State<HeadScreen> createState() => _HeadScreenState();
}

class _HeadScreenState extends State<HeadScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return BlocBuilder<NextprayCubit, NextprayState>(
      builder: (context, state) {
        if (state is NextprayLoading) {
          return Padding(
            padding: EdgeInsets.only(top: ScreenSize.hight * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: ScreenSize.hight * 0.35,
                  width: ScreenSize.width * 0.4,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          );
        } else if (state is NextpraySuccess) {
          return Padding(
            padding: EdgeInsets.only(top: ScreenSize.hight * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "My Quran",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: ScreenSize.hight * 0.05,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontsGuid.poppins,
                  ),
                ),
                Text(
                  "Read the Quran Easily",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontFamily: FontsGuid.poppins,
                    fontSize: ScreenSize.hight * 0.02,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  DateFormat('HH:mm').format(DateTime.now()),
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontsGuid.poppins,
                    fontSize: ScreenSize.hight * 0.05,
                  ),
                ),
                Text(
                  '${context.read<NextprayCubit>().nextdayModel!.month},${context.read<NextprayCubit>().nextdayModel!.date.split('-')[1]}-${context.read<NextprayCubit>().nextdayModel!.date.split('-')[2]}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: ScreenSize.hight * 0.02,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontsGuid.poppins,
                  ),
                ),
                SizedBox(height: ScreenSize.hight * 0.02),
                MaterialButton(
                  onPressed: () {
                    BlocProvider.of<FetchprayerCubit>(context).getPrayers(
                      zone:
                          context.read<LocationCubit>().zone ?? "Africa/Cairo",
                      city: context.read<LocationCubit>().loction.toString(),
                      country: context.read<LocationCubit>().address.toString(),
                    );
                    Navigator.pushNamed(context, NextPrayDetails.routeName);
                  },
                  minWidth: ScreenSize.width * 0.3,
                  height: ScreenSize.hight * 0.05,
                  color: Theme.of(context).primaryColorLight,
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
                      color: Color(0xffbfa27e),
                      fontWeight: FontWeight.bold,
                      fontFamily: FontsGuid.poppins,
                      fontSize: ScreenSize.hight * 0.025,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: ScreenSize.hight * 0.35,
            width: ScreenSize.width * 0.4,
            child: Center(
              child: IconButton(
                onPressed: () {
                  BlocProvider.of<NextprayCubit>(context).getTheNext(
                    address: context.read<LocationCubit>().address.toString(),
                    zone: context.read<LocationCubit>().zone ?? 'Africa/Cairo',
                  );
                  setState(() {});
                },
                icon: Icon(
                  Icons.refresh,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
