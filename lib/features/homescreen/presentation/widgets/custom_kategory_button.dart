import 'package:flutter/material.dart';
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
        shadowColor: Theme.of(context).shadowColor,
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: selected
            ? Theme.of(context).primaryColor
            : Theme.of(context).scaffoldBackgroundColor,
        alignment: Alignment.center,
        fixedSize: Size(ScreenSize.width * 0.28, ScreenSize.hight * 0.05),
      ),

      child: Text(
        textAlign: TextAlign.center,
        txt,
        style: TextStyle(
          color: selected
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).primaryColor,
          fontSize: ScreenSize.hight * 0.016,
          fontWeight: FontWeight.bold,
          fontFamily: FontsGuid.poppins,
        ),
      ),
    );
  }
}
