import 'package:flutter/material.dart';
import 'package:quran/core/utils/screen_size.dart';

class SoundsCustomContainer extends StatelessWidget {
  const SoundsCustomContainer({
    super.key,
    required this.path,
    required this.txt,
    required this.onTap,
  });

  final String path;
  final String txt;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenSize.hight * 0.025),
        margin: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.025,
          vertical: ScreenSize.hight * 0.025,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(ScreenSize.hight * 0.035),
          boxShadow: [
            BoxShadow(
              color: Color(0xffbfa27e),
              offset: Offset(0, 0),
              blurStyle: BlurStyle.outer,
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              path,
              width: ScreenSize.width * 0.16,
              height: ScreenSize.hight * 0.1,
              color: Color(0xffbfa27e),
              fit: BoxFit.fill,
            ),
            Text(
              txt,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: ScreenSize.hight * 0.035,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
