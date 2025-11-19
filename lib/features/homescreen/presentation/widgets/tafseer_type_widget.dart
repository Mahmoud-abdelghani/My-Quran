import 'package:flutter/material.dart';

import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';

class TafseerTypeWidget extends StatelessWidget {
  const TafseerTypeWidget({
    super.key,
    required this.num,
    required this.languge,
    required this.name,
    required this.bookName,
    required this.onTap,
  });
  final String num;
  final String languge;
  final String name;
  final String bookName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Theme.of(context).primaryColor,
      elevation: 6,
      borderRadius: BorderRadius.circular(25),
      child: ListTile(
        onTap: onTap,

        leading: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/muslim (1) 1.png",
              width: ScreenSize.width * 0.12,
              height: ScreenSize.hight * 0.1,
              color: Theme.of(context).primaryColor,
              fit: BoxFit.fill,
            ),
            Text(
              num,
              style: TextStyle(
                fontSize: ScreenSize.hight * 0.02,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ],
        ),
        trailing: Text(
          languge,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: ScreenSize.hight * 0.025,
            fontFamily: FontsGuid.poppins,
            fontWeight: FontWeight.w400,
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: ScreenSize.hight * 0.028,
            fontFamily: FontsGuid.poppins,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          bookName,
          style: TextStyle(
            fontSize: ScreenSize.hight * 0.017,
            fontFamily: FontsGuid.poppins,
            color: Theme.of(context).splashColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
