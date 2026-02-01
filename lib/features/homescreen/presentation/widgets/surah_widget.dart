import 'package:flutter/material.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';

class SurahWidget extends StatelessWidget {
  const SurahWidget({
    super.key,
    required this.title,
    required this.ayat,
    required this.nameInArabic,
    required this.place,
    required this.num,
    required this.onTap,
  });
  final String title;
  final String place;
  final String ayat;
  final String nameInArabic;
  final int num;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: Color(0xffbfa27e),
      borderRadius: BorderRadius.circular(25),
      child: ListTile(
        minVerticalPadding: ScreenSize.hight * 0.01,

        onTap: onTap,

        title: Text(
          title,
          style: TextStyle(fontSize: ScreenSize.hight * 0.028),
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
              num.toString(),
              style: TextStyle(
                fontSize: ScreenSize.hight * 0.02,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ],
        ),
        subtitle: Text(
          ayat != '' ? '$place , $ayat AYAT' : place,
          style: TextStyle(fontSize: ScreenSize.hight * 0.018),
        ),
        trailing: Text(
          nameInArabic,
          style: TextStyle(
            fontSize: ScreenSize.hight * 0.03,
            fontWeight: FontWeight.w400,
            fontFamily: FontsGuid.quranFont,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
