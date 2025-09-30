import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart' hide AudioPlayer;
import 'package:quran/core/utils/color_guid.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';

import 'package:quran/features/homescreen/presentation/cubit/quran_cubit.dart';
import 'package:quran/features/surahdetails/presentation/cubit/full_surah_cubit.dart';
import 'package:quran/features/surahdetails/presentation/pages/player_view.dart';
import 'package:quran/features/surahdetails/presentation/widgets/aya_widget.dart';

class SurahView extends StatefulWidget {
  const SurahView({super.key});
  static const routeName = "surahView";

  @override
  State<SurahView> createState() => _SurahViewState();
}

class _SurahViewState extends State<SurahView> {
  AudioPlayer player = AudioPlayer();

  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FullSurahCubit, FullSurahState>(
      builder: (context, state) {
        if (state is FullSurahLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (state is FullSurahSuccess) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
              onPressed: () async {
                Navigator.pushNamed(context, PlayerView.routeName);
              },
            ),
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: ScreenSize.hight * 0.077,
                      left: ScreenSize.width * 0.146,
                    ),
                    child: Text(
                      state.fullSurahModel.name,
                      style: TextStyle(
                        color: ColorGuid.mainColor,
                        fontSize: ScreenSize.hight * 0.05,
                        fontFamily: FontsGuid.quranFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: ScreenSize.width * 0.146),
                    child: Text(
                      state.fullSurahModel.translation,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenSize.hight * 0.03,
                        fontFamily: FontsGuid.quranFont,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: ScreenSize.hight * 0.07),
                      Text(
                        "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيمِ",
                        style: TextStyle(
                          color: ColorGuid.mainColor,
                          fontSize: ScreenSize.hight * 0.04,
                          fontFamily: FontsGuid.quranFont,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "In the name of Allah, the Most Gracious, the Most Merciful",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenSize.hight * 0.03,
                          fontFamily: FontsGuid.quranFont,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList.separated(
                  separatorBuilder: (context, index) =>
                      SizedBox(height: ScreenSize.hight * 0.05),
                  itemBuilder: (context, index) => AyaWidget(
                    num: index + 1,
                    ayaAr: state.fullSurahModel.ayatInAr[index],
                    ayaEn: state.fullSurahModel.ayatInEn[index],
                  ),
                  itemCount: state.fullSurahModel.ayatInAr.length,
                ),
              ],
            ),
          );
        } else if (state is FullSurahconnectionError) {
          return Scaffold(body: Text(state.message));
        } else {
          return Scaffold(body: Text("error while loading"));
        }
      },
    );
  }
}
