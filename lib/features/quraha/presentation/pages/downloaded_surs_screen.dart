import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/presentation/widgets/surah_widget.dart';
import 'package:quran/features/quraha/presentation/cubit/download_cubit.dart';
import 'package:quran/features/quraha/presentation/pages/play_downloaded_screen.dart';

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
                          itemBuilder: (context, index) => Material(
                            elevation: 6,
                            shadowColor: Color(0xffbfa27e),
                            borderRadius: BorderRadius.circular(25),
                            child: ListTile(
                              minVerticalPadding: ScreenSize.hight * 0.01,

                              onTap: () async {
                                Navigator.pushNamed(
                                  context,
                                  PlayDownloadedScreen.routeName,
                                  arguments: context
                                      .read<DownloadCubit>()
                                      .downloadedSurs[index],
                                );
                              },

                              title: Text(
                                context
                                    .read<DownloadCubit>()
                                    .downloadedSurs[index]
                                    .surahName,
                                style: TextStyle(
                                  fontSize: ScreenSize.hight * 0.028,
                                ),
                              ),
                              leading: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/muslim (1) 1.png",
                                    width: ScreenSize.width * 0.12,
                                    height: ScreenSize.hight * 0.1,
                                    color: Color(0xffbfa27e),
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      fontSize: ScreenSize.hight * 0.02,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                context
                                    .read<DownloadCubit>()
                                    .downloadedSurs[index]
                                    .shekName,
                                style: TextStyle(
                                  fontSize: ScreenSize.hight * 0.018,
                                ),
                              ),
                              trailing: TextButton(
                                onPressed: () {
                                  String surhaName = context
                                      .read<DownloadCubit>()
                                      .downloadedSurs[index]
                                      .surahName;
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) => CupertinoTheme(
                                      data: CupertinoThemeData(
                                        brightness: Theme.of(
                                          context,
                                        ).brightness,

                                        scaffoldBackgroundColor: Theme.of(
                                          context,
                                        ).scaffoldBackgroundColor,
                                      ),
                                      child: CupertinoAlertDialog(
                                        title: Text(
                                          'حذف السورة',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).primaryColor,
                                            fontSize: ScreenSize.hight * 0.035,
                                          ),
                                        ),
                                        content: Text(
                                          'هل انت متاكد من مسح سورة $surhaName من التنزيلات',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).primaryColorDark,
                                            fontSize: ScreenSize.hight * 0.025,
                                          ),
                                        ),
                                        actions: [
                                          CupertinoDialogAction(
                                            onPressed: () {
                                              Navigator.maybePop(context);
                                            },
                                            child: Text(
                                              'لا',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).primaryColor,
                                                fontSize:
                                                    ScreenSize.hight * 0.025,
                                              ),
                                            ),
                                          ),
                                          CupertinoDialogAction(
                                            onPressed: () async {
                                              Navigator.maybePop(context);
                                              await BlocProvider.of<
                                                    DownloadCubit
                                                  >(context)
                                                  .deleteSurah(
                                                    context
                                                        .read<DownloadCubit>()
                                                        .downloadedSurs[index]
                                                        .hiveKey,
                                                    context
                                                        .read<DownloadCubit>()
                                                        .downloadedSurs[index],
                                                  );

                                              await BlocProvider.of<
                                                    DownloadCubit
                                                  >(context)
                                                  .getDownloadedSurahs();
                                            },
                                            child: Text(
                                              'نعم',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).primaryColor,
                                                fontSize:
                                                    ScreenSize.hight * 0.025,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'حذف',
                                  style: TextStyle(
                                    fontSize: ScreenSize.hight * 0.03,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontsGuid.quranFont,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
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
