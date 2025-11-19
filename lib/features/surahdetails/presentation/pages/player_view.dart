import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/color_guid.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/surahdetails/presentation/cubit/audio_player_cubit.dart';

import 'package:quran/features/surahdetails/presentation/cubit/full_surah_cubit.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key});
  static String routeName = "PlayerView";

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  bool isPlaying = false;
  Duration duration = Duration(seconds: 0);
  String qaree = "Yasser Al Dosari";
  String? audioUrl;

  final AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    qaree = context.read<AudioPlayerCubit>().qaree;
    return Scaffold(
      backgroundColor: Color(0xff140038),
      body: Stack(
        children: [
          Image.asset(
            ThemeMode.values.first == ThemeMode.light
                ? "assets/images/BG Mobile2.png"
                : "assets/images/BG MobileDark2.png",
            width: ScreenSize.width,
            height: ScreenSize.hight * 0.596,
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(flex: 8),
              SizedBox(width: ScreenSize.width),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.skip_previous,
                    size: ScreenSize.hight * 0.06,
                    color: Color(0xff140038),
                  ),
                  InkWell(
                    onTap: () async {
                      if (!context.read<AudioPlayerCubit>().isPlaying!) {
                        await BlocProvider.of<AudioPlayerCubit>(
                          context,
                        ).playAudio(
                          context
                              .read<FullSurahCubit>()
                              .fullSurahModel!
                              .mashaih[context
                                  .read<FullSurahCubit>()
                                  .fullSurahModel!
                                  .mashaih
                                  .indexWhere(
                                    (element) =>
                                        element.name ==
                                        context.read<AudioPlayerCubit>().qaree,
                                  )]
                              .originalUrl,
                          qaree,
                        );
                      } else {
                        BlocProvider.of<AudioPlayerCubit>(context).pauseAudio();
                        context.read<AudioPlayerCubit>().changeFirstTime();
                      }

                      duration =
                          await context
                              .read<AudioPlayerCubit>()
                              .player
                              .getDuration() ??
                          Duration(seconds: 2);
                      isPlaying = !isPlaying;
                      setState(() {});
                    },
                    child: CircleAvatar(
                      radius: ScreenSize.hight * 0.04,
                      backgroundColor: Color(0xff140038),
                      child: !context.read<AudioPlayerCubit>().isPlaying!
                          ? Icon(
                              Icons.play_arrow,
                              size: ScreenSize.hight * 0.05,
                              color: Colors.grey,
                            )
                          : Icon(
                              Icons.pause,
                              size: ScreenSize.hight * 0.05,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                  Icon(
                    Icons.skip_next,
                    size: ScreenSize.hight * 0.06,
                    color: Color(0xff140038),
                  ),
                ],
              ),
              SizedBox(height: ScreenSize.hight * 0.1),
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
                          context.read<AudioPlayerCubit>().player.seek(
                            Duration(seconds: value.toInt()),
                          );
                        },
                        activeColor: Theme.of(context).primaryColor,
                        inactiveColor: Colors.grey,
                      ),
                      Row(
                        children: [
                          SizedBox(width: ScreenSize.width * 0.05),
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
                          SizedBox(width: ScreenSize.width * 0.05),
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: ScreenSize.hight * 0.02),
              Padding(
                padding: EdgeInsets.only(left: ScreenSize.width * 0.05),
                child: Text(
                  context.read<FullSurahCubit>().fullSurahModel!.name,
                  style: TextStyle(
                    fontFamily: FontsGuid.quranFont,
                    fontSize: ScreenSize.hight * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: ScreenSize.hight * 0.05,
                  horizontal: ScreenSize.width * 0.05,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: ScreenSize.hight * 0.001,
                  ),
                ),
                width: ScreenSize.width,
                height: ScreenSize.hight * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      qaree,
                      style: TextStyle(
                        fontSize: ScreenSize.hight * 0.025,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontsGuid.quranFont,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showMenu(
                          position: RelativeRect.fromSize(
                            Rect.fromLTRB(200, ScreenSize.hight * 0.6, 0, 0),
                            Size(
                              ScreenSize.width * 0.2,
                              ScreenSize.hight * 0.5,
                            ),
                          ),
                          context: context,
                          items: List.generate(
                            context
                                .read<FullSurahCubit>()
                                .fullSurahModel!
                                .mashaih
                                .length,
                            (index) => PopupMenuItem(
                              value: context
                                  .read<FullSurahCubit>()
                                  .fullSurahModel!
                                  .mashaih[index]
                                  .originalUrl,
                              child: Text(
                                context
                                    .read<FullSurahCubit>()
                                    .fullSurahModel!
                                    .mashaih[index]
                                    .name,
                              ),
                              onTap: () {
                                qaree = context
                                    .read<FullSurahCubit>()
                                    .fullSurahModel!
                                    .mashaih[index]
                                    .name;

                                setState(() {});
                              },
                            ),
                          ),
                        ).then((value) async {
                          audioUrl = value;
                          if (value != null) {
                            await context.read<AudioPlayerCubit>().playAudio(
                              audioUrl!,
                              qaree,
                            );

                            duration =
                                await context
                                    .read<AudioPlayerCubit>()
                                    .player
                                    .getDuration() ??
                                Duration(seconds: 2);
                            isPlaying = true;

                            setState(() {});
                          }
                        });
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                        size: ScreenSize.hight * 0.04,
                        weight: ScreenSize.width * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        ],
      ),
    );
  }
}
