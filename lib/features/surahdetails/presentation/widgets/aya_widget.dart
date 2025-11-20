import 'package:flutter/material.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';

class AyaWidget extends StatelessWidget {
  const AyaWidget({
    super.key,
    required this.ayaAr,
    required this.ayaEn,
    required this.num,
    required this.tafseer,
  });
  final int num;
  final String ayaAr;
  final String ayaEn;
  final bool tafseer;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenSize.hight * 0.05),
                color: Theme.of(context).secondaryHeaderColor,
              ),
              height: ScreenSize.hight * 0.07,
              width: ScreenSize.width * 0.9,
              child: Row(
                children: [
                  SizedBox(width: ScreenSize.width * 0.034),
                  CircleAvatar(
                    radius: ScreenSize.hight * 0.023,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      num.toString(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontFamily: FontsGuid.poppins,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenSize.hight * 0.022,
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.share,
                        color: Theme.of(context).primaryColor,
                        size: ScreenSize.hight * 0.035,
                      ),
                      Icon(
                        Icons.play_arrow_outlined,
                        color: Theme.of(context).primaryColor,
                        size: ScreenSize.hight * 0.05,
                      ),
                      Icon(
                        Icons.bookmark_border,
                        color: Theme.of(context).primaryColor,
                        size: ScreenSize.hight * 0.035,
                      ),
                    ],
                  ),
                  SizedBox(width: ScreenSize.width * 0.034),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: ScreenSize.width * 0.03),
            child: Text(
              ayaAr,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: ScreenSize.hight * 0.04,
                fontFamily: FontsGuid.quranFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenSize.width * 0.03),
            child: Text(
              ayaEn,
              textAlign: tafseer ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,

                fontSize: ScreenSize.hight * 0.025,
                fontFamily: FontsGuid.quranFont,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
