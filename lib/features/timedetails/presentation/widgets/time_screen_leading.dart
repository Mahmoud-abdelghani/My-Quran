import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/location_cubit.dart';

class TimeScreenLeading extends StatelessWidget {
  const TimeScreenLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenSize.hight * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Jadwal Sholat",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontsGuid.poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenSize.hight * 0.035,
                ),
              ),
              Text(
                context.read<LocationCubit>().loction.toString().split(' ')[0],
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontsGuid.poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenSize.hight * 0.03,
                ),
              ),
              Text(
                DateFormat('HH:mm').format(DateTime.now()),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontsGuid.poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenSize.hight * 0.04,
                ),
              ),
            ],
          ),
          Icon(
            Icons.notifications,
            size: ScreenSize.width * 0.25,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
