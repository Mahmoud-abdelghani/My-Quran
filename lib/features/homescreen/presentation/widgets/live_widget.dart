import 'package:flutter/material.dart';
import 'package:quran/core/utils/app_theme.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveMakkahBanner extends StatelessWidget {
  final String youtubeUrl;

  const LiveMakkahBanner({
    super.key,
    this.youtubeUrl = 'https://makkahlive.org/live/hajj',
  });

  Future<void> _openYoutube() async {
    final uri = Uri.parse(youtubeUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $youtubeUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    final hajjColors = Theme.of(context).extension<HajjSectionColors>()!;
    return GestureDetector(
      onTap: _openYoutube,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: ScreenSize.hight * 0.225,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: NetworkImage(
              'https://i.ytimg.com/vi/fZvuHkHYaXk/maxresdefault.jpg', // thumbnail الفيديو
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // طبقة تدرج فوق الصورة
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                hajjColors.liveOverlayStart,
                hajjColors.liveOverlayEnd,
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end, // RTL
            children: [
              // LIVE badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, color: Colors.white, size: 8),
                    SizedBox(width: 4),
                    Text(
                      'الآن',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // العنوان
              Text(
                'البث المباشر من  قناة الحج السعودية',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenSize.hight * 0.02,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Live from Makkah',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: ScreenSize.hight * 0.0145,
                ),
              ),

              const SizedBox(height: 8),

              // الصف السفلي: مباشر 24 ساعة + زرار مشاهدة
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زرار مشاهدة الآن
                  ElevatedButton.icon(
                    onPressed: _openYoutube,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hajjColors.liveWatchButton,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 2,
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow, size: 13),
                    label: const Text(
                      'مشاهدة الآن',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),

                  // مباشر 24 ساعة
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: hajjColors.liveStatusChip,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.circle, color: Colors.green, size: 8),
                        SizedBox(width: 4),
                        Text(
                          'مباشر 24 ساعة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenSize.hight * 0.013,
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
      ),
    );
  }
}
