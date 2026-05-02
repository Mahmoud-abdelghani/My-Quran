import 'package:flutter/material.dart';
import 'package:quran/core/utils/app_theme.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/homescreen/data/models/manasik_model.dart';

class MansakDetails extends StatelessWidget {
  const MansakDetails({super.key, required this.manasik});
  final ManasikModel manasik;
  @override
  Widget build(BuildContext context) {
    final hajjColors = Theme.of(context).extension<HajjSectionColors>()!;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.02,
        vertical: ScreenSize.hight * 0.0008,
      ),
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.02),
      decoration: BoxDecoration(
        color: hajjColors.detailsBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: hajjColors.tabBorder, width: 2),
        boxShadow: [
          BoxShadow(
            color: hajjColors.detailsGlow,
            spreadRadius: 4,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      width: ScreenSize.width,
      height: ScreenSize.hight * 0.29,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ── Header row ─────────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  manasik.image,
                  height: ScreenSize.hight * 0.1,
                  width: ScreenSize.width * 0.2,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: ScreenSize.width * 0.02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        manasik.title,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: ScreenSize.width * 0.047,
                          fontFamily: 'Trajan Pro',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: ScreenSize.hight * 0.008),
                      Text(
                        manasik.location,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: ScreenSize.width * 0.04,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: ScreenSize.hight * 0.006),
                      Text(
                        manasik.description,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: ScreenSize.width * 0.038,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: ScreenSize.hight * 0.003),

            // ── Bottom cards ────────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Steps card
                _InfoCard(
                  width: ScreenSize.width * 0.42,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ...manasik.steps.map(
                        (step) => Padding(
                          padding: EdgeInsets.only(
                            bottom: ScreenSize.hight * 0.004,
                          ),
                          child: Text(
                            step,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: ScreenSize.width * 0.034,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Trajan Pro',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Dua card
                _InfoCard(
                  width: ScreenSize.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/dua-hands.png',
                            width: ScreenSize.width * 0.07,
                            height: ScreenSize.hight * 0.038,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            'الدعاء',
                            style: TextStyle(
                              color: hajjColors.duaText,
                              fontSize: ScreenSize.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenSize.hight * 0.008),
                      Center(
                        child: Text(
                          manasik.duaArabic,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: hajjColors.duaText,
                            fontSize: ScreenSize.width * 0.032,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Trajan Pro',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.width, required this.child});

  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final hajjColors = Theme.of(context).extension<HajjSectionColors>()!;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.hight * 0.008,
        horizontal: ScreenSize.width * 0.018,
      ),
      width: width,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            hajjColors.infoCardGradientStart,
            hajjColors.infoCardGradientEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: hajjColors.infoCardShadow,
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(1, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
