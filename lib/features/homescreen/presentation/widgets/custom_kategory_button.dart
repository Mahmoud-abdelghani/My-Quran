import 'package:flutter/material.dart';
import 'package:quran/core/utils/color_guid.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';

class CustomKategoryButton extends StatelessWidget {
  const CustomKategoryButton({
    super.key,
    required this.ontap,
    required this.txt,
    required this.selected,
  });
  final String txt;
  final VoidCallback ontap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
        shadowColor: ColorGuid.mainColor,
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorGuid.mainColor),
        ),
        backgroundColor: selected ? ColorGuid.mainColor : Colors.white,
        alignment: Alignment.center,
        fixedSize: Size(ScreenSize.width * 0.35, ScreenSize.hight * 0.05),
      ),
      child: Text(
        txt,
        style: TextStyle(
          color: selected ? Colors.white : ColorGuid.mainColor,
          fontSize: ScreenSize.hight * 0.02,
          fontWeight: FontWeight.bold,
          fontFamily: FontsGuid.poppins,
        ),
      ),
    );
  }
}
