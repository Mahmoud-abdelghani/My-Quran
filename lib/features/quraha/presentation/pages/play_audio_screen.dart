import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocProvider;
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/quran_cubit.dart';
import 'package:quran/features/quraha/data/models/downloaded_surah_model.dart';
import 'package:quran/features/quraha/presentation/cubit/download_cubit.dart';
import 'package:quran/features/quraha/presentation/cubit/qrahat_cubit.dart';
import 'package:quran/features/surahdetails/presentation/cubit/audio_player_cubit.dart';

class PlayAudioScreen extends StatefulWidget {
  const PlayAudioScreen({super.key});
  static const String routeName = 'PlayAudioScreen';
  @override
  State<PlayAudioScreen> createState() => _PlayAudioScreenState();
}

class _PlayAudioScreenState extends State<PlayAudioScreen> {
  bool isPlaying = false;
  Duration duration = Duration(seconds: 0);
  String qaree = "ياسر الدوسري";
  double value = 0.0;

  String? currentUrl;
  @override
  Widget build(BuildContext context) {
    currentUrl = context
        .read<QrahatCubit>()
        .sheook!
        .elementAt(
          context.read<QrahatCubit>().sheook!.indexWhere(
            (element) => element.name == qaree,
          ),
        )
        .originalUrl;
    int suraIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  'assets/images/taj-mahal-agra-india.png',
                  width: ScreenSize.width,
                  height: ScreenSize.hight,
                  fit: BoxFit.cover,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenSize.hight * 0.04,
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
                                        .isPlaying!) {
                                      await BlocProvider.of<AudioPlayerCubit>(
                                        context,
                                      ).playAudio(
                                        context
                                            .read<QrahatCubit>()
                                            .sheook!
                                            .elementAt(
                                              context
                                                  .read<QrahatCubit>()
                                                  .sheook!
                                                  .indexWhere(
                                                    (element) =>
                                                        element.name == qaree,
                                                  ),
                                            )
                                            .originalUrl,
                                        context
                                            .read<QrahatCubit>()
                                            .sheook!
                                            .elementAt(
                                              context
                                                  .read<QrahatCubit>()
                                                  .sheook!
                                                  .indexWhere(
                                                    (element) =>
                                                        element.name == qaree,
                                                  ),
                                            )
                                            .name,
                                      );
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
                                    isPlaying = !isPlaying;
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
                                'سورة ${context.read<QuranCubit>().surs[suraIndex - 1].nameInAr}',
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
                                'القارئ $qaree',
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

                            context.read<DownloadCubit>().isDownloading
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ScreenSize.width * 0.05,
                                      vertical: ScreenSize.hight * 0.03,
                                    ),
                                    child: LinearProgressIndicator(
                                      value: value,
                                      backgroundColor: Colors.grey.shade800,
                                      color: Color(0xffE2BE7F),
                                    ),
                                  )
                                : SizedBox(height: 0),
                            SizedBox(height: ScreenSize.hight * 0.01),
                            Center(
                              child: OutlinedButton(
                                onPressed: () async {
                                  await BlocProvider.of<DownloadCubit>(
                                    context,
                                  ).downloadMp3WithDio(
                                    downloadedSurahModel: DownloadedSurahModel(
                                      surahName: context
                                          .read<QuranCubit>()
                                          .surs[suraIndex - 1]
                                          .nameInAr,
                                      translation: context
                                          .read<QuranCubit>()
                                          .surs[suraIndex - 1]
                                          .nameInEn,
                                      hiveKey: 'surah${suraIndex - 1}$qaree',
                                      shekName: qaree,
                                    ),
                                    url: currentUrl!,
                                    key: 'surah${suraIndex - 1}$qaree',
                                    onProgress: (progress) {
                                      value = progress;
                                      setState(() {});
                                    },
                                  );
                                },
                                child: Text(
                                  'تحميل',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 212, 212, 212),
                                    fontSize: ScreenSize.hight * 0.03,
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
                Positioned(
                  top: ScreenSize.hight * 0.12,
                  left: ScreenSize.width * 0.02,
                  right: ScreenSize.width * 0.02,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.width * 0.025,
                    ),
                    child: Autocomplete<String>(
                      optionsBuilder: (textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return Iterable.empty();
                        }
                        return context
                            .read<QrahatCubit>()
                            .namesForSearch!
                            .where((element) {
                              return element.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              );
                            });
                      },
                      onSelected: (option) async {
                        currentUrl = context
                            .read<QrahatCubit>()
                            .sheook!
                            .elementAt(
                              context.read<QrahatCubit>().sheook!.indexWhere(
                                (element) => element.name == option,
                              ),
                            )
                            .originalUrl;
                        await BlocProvider.of<AudioPlayerCubit>(
                          context,
                        ).playAudio(
                          context
                              .read<QrahatCubit>()
                              .sheook!
                              .elementAt(
                                context.read<QrahatCubit>().sheook!.indexWhere(
                                  (element) => element.name == option,
                                ),
                              )
                              .originalUrl,
                          context
                              .read<QrahatCubit>()
                              .sheook!
                              .elementAt(
                                context.read<QrahatCubit>().sheook!.indexWhere(
                                  (element) => element.name == option,
                                ),
                              )
                              .name,
                        );
                        duration =
                            // ignore: use_build_context_synchronously
                            await context
                                .read<AudioPlayerCubit>()
                                .player
                                .getDuration() ??
                            Duration(seconds: 2);
                        isPlaying = !isPlaying;
                        qaree = option;
                        setState(() {});
                      },
                      fieldViewBuilder:
                          (
                            context,
                            textEditingController,
                            focusNode,
                            onFieldSubmitted,
                          ) => Theme(
                            data: Theme.of(context).copyWith(
                              textSelectionTheme: const TextSelectionThemeData(
                                cursorColor: Color.fromARGB(255, 212, 212, 212),
                                selectionHandleColor: Color(0xffE2BE7F),
                              ),
                            ),
                            child: SearchBar(
                              focusNode: focusNode,
                              controller: textEditingController,
                              onSubmitted: (value) => onFieldSubmitted,
                              backgroundColor: WidgetStatePropertyAll(
                                const Color.fromARGB(106, 226, 190, 127),
                              ),
                              hintText: 'يمكنك البحث عن اى شيخ',
                              leading: Icon(Icons.search),
                              textStyle: WidgetStatePropertyAll(
                                TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenSize.hight * 0.02,
                                ),
                              ),

                              hintStyle: WidgetStatePropertyAll(
                                TextStyle(
                                  color: Color.fromARGB(255, 212, 212, 212),
                                  fontSize: ScreenSize.hight * 0.02,
                                  fontFamily: FontsGuid.poppins,
                                ),
                              ),
                            ),
                          ),
                      optionsViewBuilder: (context, onSelected, options) =>
                          ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                onSelected(options.elementAt(index));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenSize.width * 0.05,
                                  vertical: ScreenSize.hight * 0.01,
                                ),

                                color: Color.fromARGB(170, 66, 55, 37),
                                child: Text(
                                  options.elementAt(index),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenSize.hight * 0.02,
                                  ),
                                ),
                              ),
                            ),
                            itemCount: options.length <= 6 ? options.length : 6,
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
