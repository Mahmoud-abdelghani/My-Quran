import 'package:flutter/material.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';

class AyaWidget extends StatelessWidget {
  const AyaWidget({
    super.key,
    required this.ayaAr,
    this.ayaEn,
    required this.num,
    required this.tafseer,
  });
  final int num;
  final String ayaAr;
  final String? ayaEn;
  final bool tafseer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.03,
        vertical: ScreenSize.hight * 0.005,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(26, 191, 162, 126),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: ScreenSize.width * 0.03,
              top: ScreenSize.hight * 0.015,
              bottom: ScreenSize.hight * 0.015,
            ),
            child: RichText(
              textDirection: TextDirection.rtl,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: ayaAr,

                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: ScreenSize.hight * 0.035,
                      fontFamily: FontsGuid.quranFont,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: " \u06DD${num.toArabicDigits()}",
                    style: TextStyle(
                      color: Color(0xffbfa27e),
                      fontSize: ScreenSize.hight * 0.035,
                      fontFamily: FontsGuid.quranFont,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            tafseer ? "\"$ayaEn\"" : "",
            textAlign: TextAlign.start,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: ScreenSize.hight * 0.028,
              fontFamily: FontsGuid.quranFont,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

extension ArabicNumbers on int {
  String toArabicDigits() {
    const arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return toString().split('').map((e) => arabicNumbers[int.parse(e)]).join();
  }
}
