import 'package:flutter/material.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';

class ParyWidget extends StatelessWidget {
  const ParyWidget({
    super.key,
    required this.icondescription,
    required this.name,
    required this.time,
  });
  final String icondescription;
  final String name;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenSize.hight * 0.008),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            icondescription,
            width: ScreenSize.width * 0.13,
            height: ScreenSize.hight * 0.05,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: ScreenSize.hight * 0.0419,
            width: ScreenSize.width * 0.33,
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenSize.hight * 0.03,
                  fontFamily: FontsGuid.poppins,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenSize.hight * 0.03,
              fontFamily: FontsGuid.poppins,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
