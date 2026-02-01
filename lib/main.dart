import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quran/core/api/dio_concumer.dart';
import 'package:quran/core/api/end_points.dart';
import 'package:quran/core/cubit/theme_cubit.dart';
import 'package:quran/core/database/cache_helper.dart';
import 'package:quran/core/utils/app_theme.dart';
import 'package:quran/features/homescreen/data/models/surah_model_type_adaptive.dart';
import 'package:quran/features/homescreen/data/models/tafseer_type_type_adapter.dart';
import 'package:quran/features/homescreen/data/models/zekr_model_type_adapter.dart';

import 'package:quran/features/homescreen/presentation/cubit/location_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/nextpray_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/quran_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/tafseer_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/tasspeh_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/zekr_cubit.dart';
import 'package:quran/features/homescreen/presentation/pages/home_view.dart';
import 'package:quran/features/homescreen/presentation/pages/splach_view.dart';
import 'package:quran/features/quraha/data/models/downloaded_surah_model_type_adapter.dart';
import 'package:quran/features/quraha/presentation/cubit/download_cubit.dart';
import 'package:quran/features/quraha/presentation/cubit/qrahat_cubit.dart';
import 'package:quran/features/quraha/presentation/pages/downloaded_surs_screen.dart';
import 'package:quran/features/quraha/presentation/pages/play_audio_screen.dart';
import 'package:quran/features/quraha/presentation/pages/surs_selsection_screen.dart';
import 'package:quran/features/surahdetails/data/models/full_surah_model_type_adaptive.dart';
import 'package:quran/features/surahdetails/data/models/shek_model_type_adapter.dart';
import 'package:quran/features/surahdetails/presentation/cubit/audio_player_cubit.dart';
import 'package:quran/features/surahdetails/presentation/cubit/full_surah_cubit.dart';
import 'package:quran/features/surahdetails/presentation/pages/surah_view.dart';
import 'package:quran/features/tafseer/presentation/cubit/get_tafseer_cubit.dart';
import 'package:quran/features/tafseer/presentation/pages/full_tafseer.dart';
import 'package:quran/features/tafseer/presentation/pages/surah_tafseer_view.dart';
import 'package:quran/features/timedetails/cubit/fetchprayer_cubit.dart';
import 'package:quran/features/timedetails/cubit/notification_memory_cubit.dart';
import 'package:quran/features/timedetails/presentation/pages/next_pray_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SurahModelTypeAdaptive());
  Hive.registerAdapter(ZekrModelTypeAdapter());
  Hive.registerAdapter(TafseerTypeTypeAdapter());
  Hive.registerAdapter(FullSurahModelTypeAdaptive());
  Hive.registerAdapter(ShekModelTypeAdapter());
  Hive.registerAdapter(DownloadedSurahModelTypeAdapter());
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
  await CacheHelper.init();
  runApp(MyApp());
}

insureNotificationsPermissions() async {
  final status = await Permission.notification.status;
  if (status.isDenied || status.isLimited || status.isPermanentlyDenied) {
    final request = await Permission.notification.request();
    if (request.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocationCubit()),
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
        BlocProvider(
          create: (context) => TafseerCubit(
            DioConcumer(dio: Dio(), baseUrl: EndPoints.baseUrlTafseer),
          )..getTafssersTypes(),
        ),
        BlocProvider(
          create: (context) => GetTafseerCubit(
            DioConcumer(dio: Dio(), baseUrl: EndPoints.baseUrlTafseer),
          ),
        ),
        BlocProvider(create: (context) => TasspehCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => NotificationMemoryCubit()),
        BlocProvider(
          create: (context) => QrahatCubit(
            DioConcumer(dio: Dio(), baseUrl: EndPoints.baseUrlQeraat),
          ),
        ),
        BlocProvider(create: (context) => DownloadCubit()),
      ],

      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              SplachView.routeName: (context) => SplachView(),
              HomeView.routeName: (context) => HomeView(),
              NextPrayDetails.routeName: (context) => NextPrayDetails(),
              SurahView.routeName: (context) => SurahView(),
              SurahTafseerView.routeName: (context) => SurahTafseerView(),
              FullTafseer.routeName: (context) => FullTafseer(),
              SursSelsectionScreen.routeName: (context) =>
                  SursSelsectionScreen(),
              PlayAudioScreen.routeName: (context) => PlayAudioScreen(),
              DownloadedSursScreen.routeName: (context) => DownloadedSursScreen(),
            },
            initialRoute: SplachView.routeName,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state,
          );
        },
      ),
    );
  }
}
