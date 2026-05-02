import 'package:flutter/material.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/core/utils/app_theme.dart';

class MansakConstainer extends StatelessWidget {
  const MansakConstainer({
    super.key,
    required this.title,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });
  final String title;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final hajjColors = Theme.of(context).extension<HajjSectionColors>()!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: ScreenSize.hight * 0.01),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize.hight * 0.003,
          horizontal: ScreenSize.width * 0.02,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? hajjColors.tabSelectedBackground
              : hajjColors.tabUnselectedBackground,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? hajjColors.tabShadow
                  : const Color.fromARGB(26, 0, 0, 0),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          border: isSelected
              ? Border.all(color: hajjColors.tabBorder, width: 2)
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              width: ScreenSize.width * 0.125,
              height: ScreenSize.hight * 0.06,

              fit: BoxFit.fill,
            ),
            SizedBox(
              width: ScreenSize.width * 0.17,
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Trajan Pro',
                    fontSize: ScreenSize.hight * 0.015,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
