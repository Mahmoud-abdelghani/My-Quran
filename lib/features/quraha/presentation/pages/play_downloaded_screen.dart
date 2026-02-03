import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/quraha/data/models/downloaded_surah_model.dart';
import 'package:quran/features/quraha/presentation/cubit/download_cubit.dart';
import 'package:quran/features/surahdetails/presentation/cubit/audio_player_cubit.dart';

class PlayDownloadedScreen extends StatefulWidget {
  const PlayDownloadedScreen({super.key});
  static const String routeName = 'PlayDownloadedScreen';

  @override
  State<PlayDownloadedScreen> createState() => _PlayDownloadedScreenState();
}

class _PlayDownloadedScreenState extends State<PlayDownloadedScreen> {
  Duration duration = Duration(seconds: 0);
  bool firstTime = true;
  @override
  Widget build(BuildContext context) {
    DownloadedSurahModel downloadedSurahModel =
        ModalRoute.of(context)!.settings.arguments as DownloadedSurahModel;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  'assets/images/taj-mahal-agra-india 1.png',
                  width: ScreenSize.width,
                  height: ScreenSize.hight,
                  fit: BoxFit.cover,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenSize.hight * 0.08,
                    horizontal: ScreenSize.width * 0.025,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      ScreenSize.hight * 0.05,
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: ScreenSize.hight * 0.03,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffE2BE7F)),
                          borderRadius: BorderRadius.circular(
                            ScreenSize.hight * 0.05,
                          ),
                          color: Colors.transparent,
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.skip_previous,
                                  size: ScreenSize.hight * 0.06,
                                  color: Color(0xffE2BE7F),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (!context
                                            .read<AudioPlayerCubit>()
                                            .isPlaying! &&
                                        firstTime) {
                                      log(firstTime.toString());
                                      firstTime = false;
                                      await BlocProvider.of<AudioPlayerCubit>(
                                        context,
                                      ).playDownloadedAudio(
                                        downloadedSurahModel.hiveKey,
                                        downloadedSurahModel.shekName,
                                      );
                                    } else if (!firstTime &&
                                        !context
                                            .read<AudioPlayerCubit>()
                                            .isPlaying!) {
                                      await BlocProvider.of<AudioPlayerCubit>(
                                        context,
                                      ).resume();
                                    } else {
                                      BlocProvider.of<AudioPlayerCubit>(
                                        context,
                                      ).pauseAudio();
                                      context
                                          .read<AudioPlayerCubit>()
                                          .changeFirstTime();
                                    }

                                    duration =
                                        // ignore: use_build_context_synchronously
                                        await context
                                            .read<AudioPlayerCubit>()
                                            .player
                                            .getDuration() ??
                                        Duration(seconds: 2);

                                    setState(() {});
                                  },
                                  child: CircleAvatar(
                                    radius: ScreenSize.hight * 0.04,
                                    backgroundColor: Color(0xffE2BE7F),
                                    child:
                                        !context
                                            .read<AudioPlayerCubit>()
                                            .isPlaying!
                                        ? Icon(
                                            Icons.play_arrow,
                                            size: ScreenSize.hight * 0.05,
                                            color: Color.fromARGB(
                                              255,
                                              212,
                                              212,
                                              212,
                                            ),
                                          )
                                        : Icon(
                                            Icons.pause,
                                            size: ScreenSize.hight * 0.05,
                                            color: Color.fromARGB(
                                              255,
                                              212,
                                              212,
                                              212,
                                            ),
                                          ),
                                  ),
                                ),
                                Icon(
                                  Icons.skip_next,
                                  size: ScreenSize.hight * 0.06,
                                  color: Color(0xffE2BE7F),
                                ),
                              ],
                            ),
                            SizedBox(height: ScreenSize.hight * 0.025),
                            StreamBuilder<Duration>(
                              stream: context
                                  .read<AudioPlayerCubit>()
                                  .player
                                  .onPositionChanged,
                              builder: (context, snapshot) {
                                final position = snapshot.data ?? Duration.zero;

                                return Column(
                                  children: [
                                    Slider(
                                      min: 0.0,
                                      max: context
                                          .read<AudioPlayerCubit>()
                                          .duration
                                          .inSeconds
                                          .toDouble(),
                                      value: position.inSeconds
                                          .clamp(
                                            0,
                                            context
                                                .read<AudioPlayerCubit>()
                                                .duration
                                                .inSeconds,
                                          )
                                          .toDouble(),
                                      onChanged: (value) {
                                        context
                                            .read<AudioPlayerCubit>()
                                            .player
                                            .seek(
                                              Duration(seconds: value.toInt()),
                                            );
                                      },
                                      activeColor: Color(0xffE2BE7F),
                                      inactiveColor: const Color.fromARGB(
                                        255,
                                        212,
                                        212,
                                        212,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: ScreenSize.width * 0.05,
                                        ),
                                        Text(
                                          position.toString().split('.')[0],
                                          style: TextStyle(
                                            fontSize: ScreenSize.hight * 0.02,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          context
                                              .read<AudioPlayerCubit>()
                                              .duration
                                              .toString()
                                              .split('.')[0],
                                          style: TextStyle(
                                            fontSize: ScreenSize.hight * 0.02,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: ScreenSize.width * 0.05,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                right: ScreenSize.width * 0.05,
                                top: ScreenSize.hight * 0.01,
                              ),
                              child: Text(
                                'سورة ${downloadedSurahModel.surahName}',
                                style: TextStyle(
                                  fontFamily: FontsGuid.quranFont,
                                  fontSize: ScreenSize.hight * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(
                                    255,
                                    212,
                                    212,
                                    212,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: ScreenSize.width * 0.05,
                              ),
                              child: Text(
                                'القارئ ${downloadedSurahModel.shekName}',
                                style: TextStyle(
                                  fontFamily: FontsGuid.quranFont,
                                  fontSize: ScreenSize.hight * 0.03,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromARGB(
                                    255,
                                    212,
                                    212,
                                    212,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
