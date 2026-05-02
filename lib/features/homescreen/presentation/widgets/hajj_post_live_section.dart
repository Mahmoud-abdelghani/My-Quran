import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/utils/app_theme.dart';
import 'package:quran/core/utils/screen_size.dart';
import 'package:quran/features/surahdetails/presentation/cubit/audio_player_cubit.dart';

class HajjPostLiveSection extends StatefulWidget {
  const HajjPostLiveSection({super.key});

  @override
  State<HajjPostLiveSection> createState() => _HajjPostLiveSectionState();
}

class _HajjPostLiveSectionState extends State<HajjPostLiveSection> {
  // ✅ الـ state بتاع التكرار اتنقل للـ Cubit — مش محتاج local state هنا
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
      child: Column(
        children: [
          SizedBox(height: ScreenSize.hight * 0.02),
          const _SectionHeader(),
          SizedBox(height: ScreenSize.hight * 0.014),
          Row(
            children: [
              // ✅ كارد التلبية
              Expanded(
                child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
                  builder: (context, state) {
                    final cubit = context.watch<AudioPlayerCubit>();
                    return _HajjSoundCard(
                      title: 'التلبية الشرعية',
                      subtitle: 'لبيك اللهم لبيك...',
                      duration: '02:45',
                      imagePath: 'assets/images/mount-arafat.png',
                      accentColor: const Color(0xFF6B3FB0),
                      isLooping: cubit.isTalLooping, // ✅ حالة التكرار
                      onRepeatTap: () {
                        context.read<AudioPlayerCubit>().toggleTalLooping();
                      },
                      onTap: () {},
                      widget: Builder(
                        builder: (context) {
                          if (state is AudioPlayerTalLoading) {
                            return const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            );
                          }
                          return IconButton(
                            onPressed: () async {
                              if (cubit.isPlayingTal!) {
                                context
                                    .read<AudioPlayerCubit>()
                                    .pauseAudioTalbia();
                              } else {
                                await context
                                    .read<AudioPlayerCubit>()
                                    .playAudiotalbia(
                                      'https://zjnyhfgqvkoqqtowdwur.supabase.co/storage/v1/object/public/hig/kP8udlHUVyw.mp3',
                                      'التلبية الشرعية',
                                    );
                              }
                            },
                            icon: Icon(
                              cubit.isPlayingTal!
                                  ? Icons.pause_sharp
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: ScreenSize.width * 0.05,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              // ✅ كارد التكبيرات
              Expanded(
                child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
                  builder: (context, state) {
                    final cubit = context.watch<AudioPlayerCubit>();
                    return _HajjSoundCard(
                      title: 'تكبيرات التشريق',
                      subtitle: 'الله أكبر الله أكبر...',
                      duration: '01:58',
                      imagePath: 'assets/images/kaaba.png',
                      accentColor: const Color(0xFFC5922D),
                      isLooping: cubit.isTakLooping, // ✅ حالة التكرار
                      onRepeatTap: () {
                        context.read<AudioPlayerCubit>().toggleTakLooping();
                      },
                      onTap: () {},
                      widget: Builder(
                        builder: (context) {
                          if (state is AudioPlayerTakLoading) {
                            return const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            );
                          }
                          return IconButton(
                            onPressed: () async {
                              if (cubit.isPlayingTak!) {
                                context
                                    .read<AudioPlayerCubit>()
                                    .pauseAudioTakber();
                              } else {
                                await context
                                    .read<AudioPlayerCubit>()
                                    .playAudiotakber(
                                      'https://zjnyhfgqvkoqqtowdwur.supabase.co/storage/v1/object/public/hig/Takbeer%20e%20Tashreeq%20Zul%20Hijjah%20-%20MP3%20Audio.mp3',
                                      'تكبيرات التشريق',
                                    );
                              }
                            },
                            icon: Icon(
                              cubit.isPlayingTak!
                                  ? Icons.pause_sharp
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: ScreenSize.width * 0.05,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenSize.hight * 0.016),
          const _AcceptanceCard(),
          SizedBox(height: ScreenSize.hight * 0.03),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    final hajjColors = Theme.of(context).extension<HajjSectionColors>()!;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(color: hajjColors.divider, thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'التلبية والتكبيرات',
                style: TextStyle(
                  color: hajjColors.headerTitle,
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenSize.width * 0.062,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
            Expanded(
              child: Divider(color: hajjColors.divider, thickness: 1),
            ),
          ],
        ),
        SizedBox(height: ScreenSize.hight * 0.004),
        Text(
          'استمع وعش روحانيات الحج',
          style: TextStyle(
            color: hajjColors.headerSubtitle,
            fontSize: ScreenSize.width * 0.04,
            fontWeight: FontWeight.w500,
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}

class _HajjSoundCard extends StatelessWidget {
  const _HajjSoundCard({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.imagePath,
    required this.accentColor,
    required this.onTap,
    required this.widget,
    required this.isLooping, // ✅ جديد
    required this.onRepeatTap, // ✅ جديد
  });

  final String title;
  final String subtitle;
  final String duration;
  final String imagePath;
  final Color accentColor;
  final VoidCallback? onTap;
  final Widget widget;
  final bool isLooping; // ✅ جديد
  final VoidCallback onRepeatTap; // ✅ جديد

  @override
  Widget build(BuildContext context) {
    final hajjColors = Theme.of(context).extension<HajjSectionColors>()!;
    return Container(
      padding: EdgeInsets.all(ScreenSize.width * 0.03),
      decoration: BoxDecoration(
        color: hajjColors.soundCardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: hajjColors.soundCardBorder),
        boxShadow: [
          BoxShadow(
            color: hajjColors.soundCardShadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: ScreenSize.width * 0.07,
                backgroundColor: accentColor.withValues(alpha: 0.2),
                backgroundImage: AssetImage(imagePath),
              ),
              SizedBox(width: ScreenSize.width * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: ScreenSize.width * 0.048,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: ScreenSize.width * 0.036,
                        color: hajjColors.secondaryText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenSize.hight * 0.008),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ✅ زرار التكرار مع تغيير اللون لما يكون active
              IconButton(
                onPressed: onRepeatTap,
                icon: Icon(
                  Icons.refresh_rounded,
                  // ✅ لو التكرار شغال يبقى لونه بلون الـ accent، غير كده رمادي
                  color: isLooping ? accentColor : hajjColors.headerSubtitle,
                ),
              ),
              CircleAvatar(
                radius: ScreenSize.width * 0.06,
                backgroundColor: accentColor,
                child: widget,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AcceptanceCard extends StatelessWidget {
  const _AcceptanceCard();

  @override
  Widget build(BuildContext context) {
    final hajjColors = Theme.of(context).extension<HajjSectionColors>()!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ScreenSize.width * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: hajjColors.acceptanceBorder),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            hajjColors.acceptanceGradientStart,
            hajjColors.acceptanceGradientEnd,
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: ScreenSize.width * 0.18,
            height: ScreenSize.width * 0.18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/images/5456467.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: ScreenSize.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'اللهم تقبل منا واغفر لنا',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: ScreenSize.width * 0.055,
                    fontFamily:'Trajan Pro',
                    fontWeight: FontWeight.w700,
                    color: hajjColors.acceptanceTitle,
                  ),
                ),
                SizedBox(height: ScreenSize.hight * 0.004),
                Text(
                  'مع كل خطوة في مناسك.. تقرّب إلى الله',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: ScreenSize.width * 0.037,
                    color: hajjColors.secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

