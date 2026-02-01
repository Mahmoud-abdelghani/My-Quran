import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/cubit/quran_cubit.dart';
import 'package:quran/features/homescreen/presentation/widgets/surah_widget.dart';
import 'package:quran/features/quraha/presentation/cubit/qrahat_cubit.dart';
import 'package:quran/features/quraha/presentation/pages/play_audio_screen.dart';

class SursSelsectionScreen extends StatelessWidget {
  const SursSelsectionScreen({super.key});
  static const String routeName = 'SursSelsectionScreen';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QrahatCubit, QrahatState>(
      listener: (context, state) {
        if (state is QraaSuccess) {
          Navigator.of(context).pushNamed(
            PlayAudioScreen.routeName,
            arguments: context.read<QrahatCubit>().suraIndex,
          );
        } else if (state is QraaError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is QraaLoading,
          child: Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/Shape-07.png',
                      height: ScreenSize.hight * 0.45,
                      width: ScreenSize.width * 0.5,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.width * 0.015,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ScreenSize.hight * 0.07),
                      Text(
                        '  الِاسْتِمَاعُ الْمُبَاشِرُ',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: ScreenSize.hight * 0.045,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsGuid.quranFont,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: ScreenSize.hight * 0.025,
                        ),
                        child: Text(
                          'وَإِذَا قُرِئَ الْقُرْآنُ فَاسْتَمِعُوا لَهُ وَأَنْصِتُوا لَعَلَّكُمْ تُرْحَمُونَ',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontFamily: FontsGuid.quranFont,
                            fontSize: ScreenSize.hight * 0.03,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => SurahWidget(
                            title: context
                                .read<QuranCubit>()
                                .surs[index]
                                .nameInEn,
                            ayat: context
                                .read<QuranCubit>()
                                .surs[index]
                                .ayatnum
                                .toString(),
                            nameInArabic: context
                                .read<QuranCubit>()
                                .surs[index]
                                .nameInAr,
                            place: context.read<QuranCubit>().surs[index].place,
                            num: index + 1,
                            onTap: () async {
                              await BlocProvider.of<QrahatCubit>(
                                context,
                              ).fetchQuraat(surahNum: index + 1);
                            },
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: ScreenSize.hight * 0.02),
                          itemCount: context.read<QuranCubit>().surs.length,
                        ),
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        );
      },
    );
  }
}
