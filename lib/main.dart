import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran/core/api/dio_concumer.dart';
import 'package:quran/core/api/end_points.dart';

import 'package:quran/features/homescreen/presentation/cubit/location_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/nextpray_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/quran_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/zekr_cubit.dart';
import 'package:quran/features/homescreen/presentation/pages/home_view.dart';
import 'package:quran/features/homescreen/presentation/pages/splach_view.dart';
import 'package:quran/features/surahdetails/presentation/cubit/audio_player_cubit.dart';

import 'package:quran/features/surahdetails/presentation/cubit/full_surah_cubit.dart';
import 'package:quran/features/surahdetails/presentation/pages/player_view.dart';
import 'package:quran/features/surahdetails/presentation/pages/surah_view.dart';
import 'package:quran/features/timedetails/cubit/fetchprayer_cubit.dart';
import 'package:quran/features/timedetails/presentation/pages/next_pray_details.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocationCubit()..getLocation()),
        BlocProvider(
          create: (context) => NextprayCubit(
            DioConcumer(baseUrl: EndPoints.baseUrlTimes, dio: Dio()),
          ),
        ),
        BlocProvider(
          create: (context) => FetchprayerCubit(
            DioConcumer(baseUrl: EndPoints.baseUrlPrayers, dio: Dio()),
          ),
        ),
        BlocProvider(
          create: (context) => QuranCubit(
            DioConcumer(baseUrl: EndPoints.baseUrlQuran, dio: Dio()),
          )..fetchQuran(),
        ),
        BlocProvider(
          create: (context) => ZekrCubit(
            DioConcumer(baseUrl: EndPoints.baseUrlAzkar, dio: Dio()),
          )..getAzkar(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => FullSurahCubit(
            DioConcumer(dio: Dio(), baseUrl: EndPoints.baseUrlQuran),
          ),
        ),
        BlocProvider(create: (context) => AudioPlayerCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SplachView.routeName: (context) => SplachView(),
          HomeView.routeName: (context) => HomeView(),
          NextPrayDetails.routeName: (context) => NextPrayDetails(),
          SurahView.routeName: (context) => SurahView(),
          PlayerView.routeName: (context) => PlayerView(),
        },
        initialRoute: SplachView.routeName,
      ),
    );
  }
}
