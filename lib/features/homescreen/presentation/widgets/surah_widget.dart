import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/color_guid.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/surahdetails/presentation/cubit/full_surah_cubit.dart';
import 'package:quran/features/surahdetails/presentation/pages/surah_view.dart';

class SurahWidget extends StatelessWidget {
  const SurahWidget({
    super.key,
    required this.title,
    required this.ayat,
    required this.nameInArabic,
    required this.place,
    required this.num,
  });
  final String title;
  final String place;
  final String ayat;
  final String nameInArabic;
  final int num;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: ColorGuid.mainColor,
      borderRadius: BorderRadius.circular(25),
      child: ListTile(
        minVerticalPadding: ScreenSize.hight * 0.01,

        onTap: () {
          BlocProvider.of<FullSurahCubit>(context).getFullSurah(num);
          Navigator.pushNamed(context, SurahView.routeName);
        },
        tileColor: Colors.white,

        title: Text(
          title,
          style: TextStyle(fontSize: ScreenSize.hight * 0.028),
        ),
        leading: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/muslim (1) 1.png",
              width: ScreenSize.width * 0.08,
              height: ScreenSize.hight * 0.1,
              fit: BoxFit.fill,
            ),
            Text(
              num.toString(),
              style: TextStyle(fontSize: ScreenSize.hight * 0.02),
            ),
          ],
        ),
        subtitle: Text(
          '$place , $ayat AYAT',
          style: TextStyle(fontSize: ScreenSize.hight * 0.018),
        ),
        trailing: Text(
          nameInArabic,
          style: TextStyle(
            fontSize: ScreenSize.hight * 0.03,
            fontWeight: FontWeight.w400,
            fontFamily: FontsGuid.quranFont,
            color: ColorGuid.mainColor,
          ),
        ),
      ),
    );
  }
}
