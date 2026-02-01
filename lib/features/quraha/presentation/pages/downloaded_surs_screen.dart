import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/widgets/surah_widget.dart';
import 'package:quran/features/quraha/presentation/cubit/download_cubit.dart';

class DownloadedSursScreen extends StatelessWidget {
  const DownloadedSursScreen({super.key});
  static const String routeName = 'downloaded-surs';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadCubit, DownloadState>(
      builder: (context, state) {
        if (state is DownloadedSursloading) {
          return Scaffold(
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
                        '  السُّوَرُ الْمُحَمَّلَةُ',
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
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        if (state is DownloadedSursFailure) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${state.errorMessage}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: ScreenSize.hight * 0.025,
                ),
              ),
            ),
          );
        }
        if (state is DownloadedSursSuccess) {
          return Scaffold(
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
                        '  السُّوَرُ الْمُحَمَّلَةُ',
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
                                .read<DownloadCubit>()
                                .downloadedSurs[index]
                                .translation,
                            ayat: '',
                            nameInArabic: context
                                .read<DownloadCubit>()
                                .downloadedSurs[index]
                                .surahName,
                            place: context
                                .read<DownloadCubit>()
                                .downloadedSurs[index]
                                .shekName,
                            num: index + 1,
                            onTap: () async {},
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: ScreenSize.hight * 0.02),
                          itemCount: context
                              .read<DownloadCubit>()
                              .downloadedSurs
                              .length,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
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
                        '  السُّوَرُ الْمُحَمَّلَةُ',
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
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
