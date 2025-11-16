import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:quran/core/utils/color_guid.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/location_cubit.dart';
import 'package:quran/features/homescreen/presentation/cubit/quran_cubit.dart';
import 'package:quran/features/homescreen/presentation/widgets/azkar_m_widget.dart';
import 'package:quran/features/homescreen/presentation/widgets/azkar_s_widget.dart';
import 'package:quran/features/homescreen/presentation/widgets/compass_widget.dart';
import 'package:quran/features/homescreen/presentation/widgets/custom_kategory_button.dart';
import 'package:quran/features/homescreen/presentation/widgets/head_screen.dart';
import 'package:quran/features/homescreen/presentation/widgets/sepha_widget.dart';
import 'package:quran/features/homescreen/presentation/widgets/surah_widget.dart';
import 'package:quran/features/homescreen/presentation/widgets/surat_widget.dart';
import 'package:quran/features/homescreen/presentation/widgets/tafser_widget.dart';
import 'package:quran/features/surahdetails/presentation/cubit/audio_player_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String routeName = "homeView";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool quranSelected = true;
  bool azkarSelected = false;

  List<bool> buttonsStates = [true, false, false, false, false, false];
  List<String> buttonsTexts = [
    'السُّوَرُ',
    'التَّفْسِيرُ',
    'القِبْلَةُ',
    'التَّسْبِيحُ',
    'أذْكَارُ الصَّبَاحِ',
    'أَذْكَارُ الْمَسَاءِ',
  ];
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: context.read<AudioPlayerCubit>().firstTime
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    context.read<AudioPlayerCubit>().isPlaying!
                        ? context.read<AudioPlayerCubit>().pauseAudio()
                        : context.read<AudioPlayerCubit>().resume();
                  },
                  backgroundColor: ColorGuid.mainColor,
                  child: context.read<AudioPlayerCubit>().isPlaying!
                      ? Icon(Icons.pause, color: Colors.white)
                      : Icon(Icons.play_arrow, color: Colors.white),
                ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(left: ScreenSize.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadScreen(),
                SizedBox(height: ScreenSize.hight * .02),
                SizedBox(
                  width: ScreenSize.width,
                  height: ScreenSize.hight * 0.06,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: buttonsTexts.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(width: ScreenSize.width * 0.1),
                    itemBuilder: (context, index) => CustomKategoryButton(
                      ontap: () {
                        setState(() {
                          buttonsStates = [
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                          ];
                          buttonsStates[index] = true;
                        });
                      },
                      txt: buttonsTexts[index],
                      selected: buttonsStates[index],
                    ),
                  ),
                ),
                if (buttonsStates.elementAt(0)) SuratWidget(),
                if (buttonsStates.elementAt(1)) TafserWidget(),
                if (buttonsStates.elementAt(2)) CompassWidget(),
                if (buttonsStates.elementAt(3)) SephaWidget(),
                if (buttonsStates.elementAt(4)) AzkarSWidget(),
                if (buttonsStates.elementAt(5)) AzkarMWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
