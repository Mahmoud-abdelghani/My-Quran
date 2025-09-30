import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/location_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/nextpray_cubit.dart';
import 'package:quran/features/timedetails/cubit/fetchprayer_cubit.dart';
import 'package:quran/features/timedetails/presentation/widgets/pary_widget.dart';
import 'package:quran/features/timedetails/presentation/widgets/time_screen_leading.dart';

class NextPrayDetails extends StatefulWidget {
  const NextPrayDetails({super.key});
  static const String routeName = "NextPrayDetails";

  @override
  State<NextPrayDetails> createState() => _NextPrayDetailsState();
}

class _NextPrayDetailsState extends State<NextPrayDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff180b37),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/image 12.png",
            width: ScreenSize.width,
            height: ScreenSize.hight * 0.49,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              TimeScreenLeading(),
              SizedBox(height: ScreenSize.hight * 0.115),
              Text(
                '${context.read<NextprayCubit>().nextdayModel!.nextPray.keys.first}  ${context.read<NextprayCubit>().nextdayModel!.nextPray[context.read<NextprayCubit>().nextdayModel!.nextPray.keys.first]}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontsGuid.poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenSize.hight * 0.035,
                ),
              ),
              SizedBox(height: ScreenSize.hight * 0.046),
              Container(
                alignment: Alignment.center,
                height: ScreenSize.hight * 0.074,
                width: ScreenSize.width * 0.816,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(ScreenSize.hight * 0.1),
                ),
                child: Text(
                  context.read<NextprayCubit>().nextdayModel!.dayDate,
                  style: TextStyle(
                    fontFamily: FontsGuid.poppins,
                    fontSize: ScreenSize.hight * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              BlocBuilder<FetchprayerCubit, FetchprayerState>(
                builder: (context, state) {
                  if (state is FetchprayerLoading) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    );
                  } else if (state is FetchprayerSuccess) {
                    print(state.prayers.prayers);
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.prayers.prayers.length,
                        itemBuilder: (context, index) {
                          if (context.read<FetchprayerCubit>().prayers.contains(
                            state.prayers.prayers[index].name,
                          )) {
                            return ParyWidget(
                              icondescription: index < 3
                                  ? context
                                        .read<FetchprayerCubit>()
                                        .timesIcons[2]
                                  : index > 2 && index < 4
                                  ? context
                                        .read<FetchprayerCubit>()
                                        .timesIcons[1]
                                  : context
                                        .read<FetchprayerCubit>()
                                        .timesIcons[0],
                              name: state.prayers.prayers[index].name,
                              time: state.prayers.prayers[index].time,
                            );
                          } else {
                            return SizedBox(height: 0, width: 0);
                          }
                        },
                      ),
                    );
                  } else {
                    return Text("error");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
