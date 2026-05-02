import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quran/core/utils/screen_size.dart';

class WaitingArafa extends StatefulWidget {
  const WaitingArafa({
    super.key,
    this.hajjContentAvailable = false,
    required this.targetMonth,
  });

  final bool hajjContentAvailable;
  final int targetMonth;

  @override
  State<WaitingArafa> createState() => _WaitingArafaState();
}

class _WaitingArafaState extends State<WaitingArafa> {
  Timer? _ticker;
  Duration _remaining = Duration.zero;
  DateTime _targetDate = DateTime.now();
  late final DateTime _animationEpoch;

  @override
  void initState() {
    super.initState();
    _animationEpoch = DateTime.now();
    _refreshCountdown();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      _refreshCountdown();
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _refreshCountdown() {
    final DateTime now = DateTime.now();
    final DateTime nextTarget = _nextMonthTargetDate(now, widget.targetMonth);
    final Duration diff = nextTarget.difference(now);

    if (!mounted) return;
    setState(() {
      _targetDate = nextTarget;
      _remaining = diff.isNegative ? Duration.zero : diff;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hajjContentAvailable ||
        widget.targetMonth < 1 ||
        widget.targetMonth > 12) {
      return const SizedBox.shrink();
    }

    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    final int days = _remaining.inDays;
    final int hours = _remaining.inHours.remainder(24);
    final int minutes = _remaining.inMinutes.remainder(60);
    final int seconds = _remaining.inSeconds.remainder(60);
    final double t =
        DateTime.now().difference(_animationEpoch).inMilliseconds / 1000;
    final double glowPulse = 0.6 + (math.sin(t * 0.8) + 1) * 0.2;

    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool compact = constraints.maxWidth < 380;
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(compact ? 16 : 22),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFF1E1040), // بنفسجي غامق
                          Color(0xFF2D1B69), // بنفسجي متوسط
                          Color(0xFF1A0E3A), // بنفسجي غامق جداً
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF9B59F5,
                          ).withValues(alpha: 0.20 * glowPulse),
                          blurRadius: 34,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -44,
                          left: -26,
                          child: _GlowCircle(
                            size: compact ? 130 : 160,
                            color: const Color(
                              0xFFAB7FF5,
                            ).withValues(alpha: 0.22),
                          ),
                        ),
                        Positioned(
                          bottom: -52,
                          right: -28,
                          child: _GlowCircle(
                            size: compact ? 145 : 185,
                            // ignore: deprecated_member_use
                            color: const Color(
                              0xFFF6E7A7,
                            ).withValues(alpha: 0.14),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: BackdropFilter(
                            filter: ColorFilter.mode(
                              Colors.white.withValues(alpha: 0.03),
                              BlendMode.srcOver,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(compact ? 8 : 9),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: Colors.white.withValues(alpha: 0.06),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.14),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        '☾',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFFF6E7A7),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'العد التنازلي لموسم الحج',
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Trajan Pro',
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'استعد لأفضل أيام العام بالطاعات والذكر والدعاء',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.86,
                                      ),
                                      height: 1.4,
                                      fontSize:
                                          ScreenSize.width *
                                          (compact ? 0.035 : 0.038),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      _TimeUnitCard(
                                        value: days.toString(),
                                        label: 'يوم',
                                        accent: const Color(0xFFB39DFF),
                                        compact: compact,
                                      ),
                                      _TimeUnitCard(
                                        value: hours.toString().padLeft(2, '0'),
                                        label: 'ساعة',
                                        accent: const Color(0xFF9B8FFF),
                                        compact: compact,
                                      ),
                                      _TimeUnitCard(
                                        value: minutes.toString().padLeft(
                                          2,
                                          '0',
                                        ),
                                        label: 'دقيقة',
                                        accent: const Color(0xFFF8D38D),
                                        compact: compact,
                                      ),
                                      _TimeUnitCard(
                                        value: seconds.toString().padLeft(
                                          2,
                                          '0',
                                        ),
                                        label: 'ثانية',
                                        accent: const Color(0xFFE8B4FF),
                                        compact: compact,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    '$days يوم | $hours ساعة | $minutes دقيقة | $seconds ثانية',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: colors.onSurface.withValues(
                                        alpha: 0.8,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          ScreenSize.width *
                                          (compact ? 0.032 : 0.035),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'الموعد: ${_targetDate.year}/${_targetDate.month.toString().padLeft(2, '0')}/${_targetDate.day.toString().padLeft(2, '0')}',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.68,
                                      ),
                                      fontSize:
                                          ScreenSize.width *
                                          (compact ? 0.035 : 0.038),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: ScreenSize.hight * 0.06),
          ],
        ),
      ),
    );
  }
}

class _TimeUnitCard extends StatelessWidget {
  const _TimeUnitCard({
    required this.value,
    required this.label,
    required this.accent,
    required this.compact,
  });

  final String value;
  final String label;
  final Color accent;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: compact ? ScreenSize.width * 0.18 : ScreenSize.width * 0.18,
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 9 : 11,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            accent.withValues(alpha: 0.25),
            Colors.white.withValues(alpha: 0.06),
          ],
        ),
        border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}

DateTime _nextMonthTargetDate(DateTime now, int targetMonth) {
  DateTime candidate = DateTime(now.year, targetMonth, 1);
  if (!candidate.isAfter(now)) {
    candidate = DateTime(now.year + 1, targetMonth, 1);
  }
  return candidate;
}
