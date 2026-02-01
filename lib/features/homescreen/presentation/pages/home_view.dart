import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/cubit/theme_cubit.dart';
import 'package:quran/core/services/local_notification_service.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/widgets/azkar_m_widget.dart';
import 'package:quran/features/homescreen/presentation/widgets/azkar_s_widget.dart';
import 'package:quran/features/homescreen/presentation/widgets/compass_widget.dart';
import 'package:quran/features/homescreen/presentation/widgets/custom_kategory_button.dart';
import 'package:quran/features/homescreen/presentation/widgets/head_screen.dart';
import 'package:quran/features/homescreen/presentation/widgets/sepha_widget.dart';
import 'package:quran/features/homescreen/presentation/widgets/sounds_lib.dart';
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
  void streamListener() {
    LocalNotificationService.notifyStreamController.stream.listen((event) {
      switch (event.payload.toString()) {
        case 'El_Sabah':
          {
            buttonsStates = [false, false, false, false, false, true];
            break;
          }
        case 'El_Massa':
          {
            buttonsStates = [false, false, false, false, true, false];

            break;
          }
        default:
          {}
      }
    });
  }

  ScrollController scrollController = ScrollController();
  List<bool> buttonsStates = [true, false, false, false, false, false, false];
  List<String> buttonsTexts = [
    'السُّوَرُ',
    'التَّفْسِيرُ',
    'مَكْتَبَةُ الصَّوْتِ',
    'القِبْلَةُ',
    'التَّسْبِيحُ',
    'أذْكَارُ الصَّبَاحِ',
    'أَذْكَارُ الْمَسَاءِ',
  ];
  @override
  void initState() {
    super.initState();
    streamListener();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: context.read<AudioPlayerCubit>().firstTime
              ? null
              : FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    context.read<AudioPlayerCubit>().isPlaying!
                        ? context.read<AudioPlayerCubit>().pauseAudio()
                        : context.read<AudioPlayerCubit>().resume();
                  },

                  child: context.read<AudioPlayerCubit>().isPlaying!
                      ? Icon(
                          Icons.pause,
                          color: Theme.of(context).primaryColorDark,
                        )
                      : Icon(
                          Icons.play_arrow,
                          color: Theme.of(context).primaryColorDark,
                        ),
                ),

          body: Stack(
            children: [
              Positioned(
                right: 0,
                bottom: 0,
                child: Image.asset(
                  'assets/images/Shape-04.png',
                  width: ScreenSize.width * 0.55,
                  height: ScreenSize.hight * 0.5,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: ScreenSize.hight * 0.3,
                left: ScreenSize.width * 0.05,
                right: ScreenSize.width * 0.7,
                child: Image.asset(
                  'assets/images/Glow.png',
                  width: ScreenSize.width * 0.1,
                  height: ScreenSize.hight * 0.4,

                  fit: BoxFit.cover,
                ),
              ),

              Image.asset(
                'assets/images/Intersect.png',
                width: ScreenSize.width,
                height: ScreenSize.hight * 0.4,

                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.only(left: ScreenSize.width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeadScreen(),
                    SizedBox(height: ScreenSize.hight * .03),
                    SizedBox(
                      width: ScreenSize.width,
                      height: ScreenSize.hight * 0.07,
                      child: ListView.separated(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: buttonsTexts.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: ScreenSize.width * 0.05),
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
                    if (buttonsStates.elementAt(1))
                      TafserWidget(context2: context),
                    if (buttonsStates.elementAt(2)) SoundsLib(),
                    if (buttonsStates.elementAt(3)) CompassWidget(),
                    if (buttonsStates.elementAt(4)) SephaWidget(),
                    if (buttonsStates.elementAt(5)) AzkarSWidget(),
                    if (buttonsStates.elementAt(6)) AzkarMWidget(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
