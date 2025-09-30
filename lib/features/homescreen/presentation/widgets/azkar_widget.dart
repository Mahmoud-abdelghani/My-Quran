import 'package:flutter/material.dart';
import 'package:quran/core/utils/color_guid.dart';
import 'package:quran/core/utils/fonts_guid.dart';
import 'package:quran/core/utils/screen_size.dart';

class AzkarWidget extends StatefulWidget {
  AzkarWidget({
    super.key,
    required this.title,
    required this.num,
    required this.zekr,
  });
  final String title;
  int num;
  final String zekr;

  @override
  State<AzkarWidget> createState() => _AzkarWidgetState();
}

class _AzkarWidgetState extends State<AzkarWidget> {
  bool initailExpand = false;
  ExpansibleController expansibleController = ExpansibleController();
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: ColorGuid.mainColor,
      borderRadius: BorderRadius.circular(25),
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.num != 0 ? widget.num-- : widget.num = 0;
          });
        },
        child: ExpansionTile(
          backgroundColor: Colors.white,
          showTrailingIcon: false,

          title: Text(
            widget.title,
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
                widget.num.toString(),
                style: TextStyle(fontSize: ScreenSize.hight * 0.02),
              ),
            ],
          ),
          subtitle: !expansibleController.isExpanded
              ? Text(
                  textDirection: TextDirection.rtl,
                  widget.zekr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenSize.hight * 0.018,
                    color: ColorGuid.mainColor,
                    fontFamily: FontsGuid.quranFont,
                  ),
                )
              : null,
          childrenPadding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.05,
          ),
          enabled: widget.num != 0,
          collapsedBackgroundColor: Colors.white,
          internalAddSemanticForOnTap: true,

          onExpansionChanged: (value) {
            setState(() {});
          },
          controller: expansibleController,
          children: [
            Text(
              widget.zekr,
              style: TextStyle(
                fontSize: ScreenSize.hight * 0.018,
                color: ColorGuid.mainColor,
                fontFamily: FontsGuid.quranFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
