import 'package:flutter/material.dart';
import 'package:quran/core/utils/color_guid.dart';

@immutable
class HajjSectionColors extends ThemeExtension<HajjSectionColors> {
  const HajjSectionColors({
    required this.tabSelectedBackground,
    required this.tabUnselectedBackground,
    required this.tabShadow,
    required this.tabBorder,
    required this.detailsBackground,
    required this.detailsGlow,
    required this.infoCardGradientStart,
    required this.infoCardGradientEnd,
    required this.infoCardShadow,
    required this.duaText,
    required this.soundCardBackground,
    required this.soundCardBorder,
    required this.soundCardShadow,
    required this.secondaryText,
    required this.divider,
    required this.headerTitle,
    required this.headerSubtitle,
    required this.acceptanceBorder,
    required this.acceptanceGradientStart,
    required this.acceptanceGradientEnd,
    required this.acceptanceTitle,
    required this.liveOverlayStart,
    required this.liveOverlayEnd,
    required this.liveWatchButton,
    required this.liveStatusChip,
  });

  final Color tabSelectedBackground;
  final Color tabUnselectedBackground;
  final Color tabShadow;
  final Color tabBorder;
  final Color detailsBackground;
  final Color detailsGlow;
  final Color infoCardGradientStart;
  final Color infoCardGradientEnd;
  final Color infoCardShadow;
  final Color duaText;
  final Color soundCardBackground;
  final Color soundCardBorder;
  final Color soundCardShadow;
  final Color secondaryText;
  final Color divider;
  final Color headerTitle;
  final Color headerSubtitle;
  final Color acceptanceBorder;
  final Color acceptanceGradientStart;
  final Color acceptanceGradientEnd;
  final Color acceptanceTitle;
  final Color liveOverlayStart;
  final Color liveOverlayEnd;
  final Color liveWatchButton;
  final Color liveStatusChip;

  @override
  HajjSectionColors copyWith({
    Color? tabSelectedBackground,
    Color? tabUnselectedBackground,
    Color? tabShadow,
    Color? tabBorder,
    Color? detailsBackground,
    Color? detailsGlow,
    Color? infoCardGradientStart,
    Color? infoCardGradientEnd,
    Color? infoCardShadow,
    Color? duaText,
    Color? soundCardBackground,
    Color? soundCardBorder,
    Color? soundCardShadow,
    Color? secondaryText,
    Color? divider,
    Color? headerTitle,
    Color? headerSubtitle,
    Color? acceptanceBorder,
    Color? acceptanceGradientStart,
    Color? acceptanceGradientEnd,
    Color? acceptanceTitle,
    Color? liveOverlayStart,
    Color? liveOverlayEnd,
    Color? liveWatchButton,
    Color? liveStatusChip,
  }) {
    return HajjSectionColors(
      tabSelectedBackground: tabSelectedBackground ?? this.tabSelectedBackground,
      tabUnselectedBackground:
          tabUnselectedBackground ?? this.tabUnselectedBackground,
      tabShadow: tabShadow ?? this.tabShadow,
      tabBorder: tabBorder ?? this.tabBorder,
      detailsBackground: detailsBackground ?? this.detailsBackground,
      detailsGlow: detailsGlow ?? this.detailsGlow,
      infoCardGradientStart: infoCardGradientStart ?? this.infoCardGradientStart,
      infoCardGradientEnd: infoCardGradientEnd ?? this.infoCardGradientEnd,
      infoCardShadow: infoCardShadow ?? this.infoCardShadow,
      duaText: duaText ?? this.duaText,
      soundCardBackground: soundCardBackground ?? this.soundCardBackground,
      soundCardBorder: soundCardBorder ?? this.soundCardBorder,
      soundCardShadow: soundCardShadow ?? this.soundCardShadow,
      secondaryText: secondaryText ?? this.secondaryText,
      divider: divider ?? this.divider,
      headerTitle: headerTitle ?? this.headerTitle,
      headerSubtitle: headerSubtitle ?? this.headerSubtitle,
      acceptanceBorder: acceptanceBorder ?? this.acceptanceBorder,
      acceptanceGradientStart:
          acceptanceGradientStart ?? this.acceptanceGradientStart,
      acceptanceGradientEnd: acceptanceGradientEnd ?? this.acceptanceGradientEnd,
      acceptanceTitle: acceptanceTitle ?? this.acceptanceTitle,
      liveOverlayStart: liveOverlayStart ?? this.liveOverlayStart,
      liveOverlayEnd: liveOverlayEnd ?? this.liveOverlayEnd,
      liveWatchButton: liveWatchButton ?? this.liveWatchButton,
      liveStatusChip: liveStatusChip ?? this.liveStatusChip,
    );
  }

  @override
  ThemeExtension<HajjSectionColors> lerp(
    covariant ThemeExtension<HajjSectionColors>? other,
    double t,
  ) {
    if (other is! HajjSectionColors) return this;
    return HajjSectionColors(
      tabSelectedBackground:
          Color.lerp(tabSelectedBackground, other.tabSelectedBackground, t)!,
      tabUnselectedBackground:
          Color.lerp(tabUnselectedBackground, other.tabUnselectedBackground, t)!,
      tabShadow: Color.lerp(tabShadow, other.tabShadow, t)!,
      tabBorder: Color.lerp(tabBorder, other.tabBorder, t)!,
      detailsBackground: Color.lerp(detailsBackground, other.detailsBackground, t)!,
      detailsGlow: Color.lerp(detailsGlow, other.detailsGlow, t)!,
      infoCardGradientStart:
          Color.lerp(infoCardGradientStart, other.infoCardGradientStart, t)!,
      infoCardGradientEnd:
          Color.lerp(infoCardGradientEnd, other.infoCardGradientEnd, t)!,
      infoCardShadow: Color.lerp(infoCardShadow, other.infoCardShadow, t)!,
      duaText: Color.lerp(duaText, other.duaText, t)!,
      soundCardBackground:
          Color.lerp(soundCardBackground, other.soundCardBackground, t)!,
      soundCardBorder: Color.lerp(soundCardBorder, other.soundCardBorder, t)!,
      soundCardShadow: Color.lerp(soundCardShadow, other.soundCardShadow, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      headerTitle: Color.lerp(headerTitle, other.headerTitle, t)!,
      headerSubtitle: Color.lerp(headerSubtitle, other.headerSubtitle, t)!,
      acceptanceBorder: Color.lerp(acceptanceBorder, other.acceptanceBorder, t)!,
      acceptanceGradientStart:
          Color.lerp(acceptanceGradientStart, other.acceptanceGradientStart, t)!,
      acceptanceGradientEnd:
          Color.lerp(acceptanceGradientEnd, other.acceptanceGradientEnd, t)!,
      acceptanceTitle: Color.lerp(acceptanceTitle, other.acceptanceTitle, t)!,
      liveOverlayStart: Color.lerp(liveOverlayStart, other.liveOverlayStart, t)!,
      liveOverlayEnd: Color.lerp(liveOverlayEnd, other.liveOverlayEnd, t)!,
      liveWatchButton: Color.lerp(liveWatchButton, other.liveWatchButton, t)!,
      liveStatusChip: Color.lerp(liveStatusChip, other.liveStatusChip, t)!,
    );
  }
}

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.white),
  buttonTheme: ButtonThemeData(buttonColor: ColorGuid.mainColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(ColorGuid.mainColor),
      shadowColor: WidgetStatePropertyAll(ColorGuid.mainColor),
      textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
    ),
  ),
  
  appBarTheme: AppBarTheme(
    backgroundColor: ColorGuid.mainColor,
    titleTextStyle: TextStyle(color: Colors.white),
    shadowColor: ColorGuid.mainColor,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.white,
    titleTextStyle: TextStyle(color: Colors.black),
  ),
  shadowColor: ColorGuid.mainColor,
  primaryColorLight: Colors.white,
  primaryColor: ColorGuid.mainColor,
  splashColor: Colors.grey,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: ColorGuid.mainColor,
  ),
  expansionTileTheme: ExpansionTileThemeData(backgroundColor: Colors.white),
  primaryColorDark: Colors.black,
  secondaryHeaderColor: Color(0xfff9f5fd),
  dialogTheme: DialogThemeData(backgroundColor: Colors.white),
  brightness: Brightness.light,
  extensions: const <ThemeExtension<dynamic>>[
    HajjSectionColors(
      tabSelectedBackground: Color(0xFF717171),
      tabUnselectedBackground: Color(0xAAC9C9C9),
      tabShadow: Color(0x80000000),
      tabBorder: Color(0xFFBFA27E),
      detailsBackground: Color(0xC8FFFFFF),
      detailsGlow: Color(0x289543FF),
      infoCardGradientStart: Color(0xC5FFFFFF),
      infoCardGradientEnd: Color(0xEEFFFFFF),
      infoCardShadow: Color(0xFF9E9E9E),
      duaText: Colors.black,
      soundCardBackground: Color(0xFFF7F6FA),
      soundCardBorder: Color(0xFFE5DEEF),
      soundCardShadow: Color(0x14000000),
      secondaryText: Color(0x8A000000),
      divider: Color(0xFFE4D7BF),
      headerTitle: Color(0xFF4F2A83),
      headerSubtitle: Color(0xFF5F5A66),
      acceptanceBorder: Color(0xFFE6D6B6),
      acceptanceGradientStart: Color(0xFFF5EAD7),
      acceptanceGradientEnd: Color(0xFFF0E0C8),
      acceptanceTitle: Color(0xFF2C2B2E),
      liveOverlayStart: Color(0xBF000000),
      liveOverlayEnd: Color(0x33000000),
      liveWatchButton: Color(0xACC2931C),
      liveStatusChip: Color(0x61000000),
    ),
  ],
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xff121212),
  iconTheme: IconThemeData(color: Color(0xff121212)),
  buttonTheme: ButtonThemeData(buttonColor: Color(0xff720D96)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xff720D96)),
      shadowColor: WidgetStatePropertyAll(Color(0xff720D96)),
      textStyle: WidgetStatePropertyAll(TextStyle(color: Color(0xff121212))),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff720D96),
    titleTextStyle: TextStyle(color: Color(0xff121212)),
    shadowColor: Color(0xff720D96),
    iconTheme: IconThemeData(color: Color(0xff121212)),
  ),
  listTileTheme: ListTileThemeData(
    tileColor: Color(0xff121212),
    titleTextStyle: TextStyle(color: Colors.white),
  ),
  shadowColor: Color(0xff720D96),
  primaryColorLight: Colors.white,
  primaryColor: Color(0xff720D96),
  splashColor: Colors.grey,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff720D96),
  ),
  expansionTileTheme: ExpansionTileThemeData(
    backgroundColor: Color(0xff121212),
    collapsedBackgroundColor: Color(0xff121212),
  ),
  primaryColorDark: Colors.white,
  secondaryHeaderColor: Color.fromARGB(189, 45, 0, 87),
  dialogTheme: DialogThemeData(backgroundColor: Color(0xff121212)),
  brightness: Brightness.dark,
  extensions: const <ThemeExtension<dynamic>>[
    HajjSectionColors(
      tabSelectedBackground: Color(0xFF4A4457),
      tabUnselectedBackground: Color(0x665B5568),
      tabShadow: Color(0x66000000),
      tabBorder: Color(0xFFBFA27E),
      detailsBackground: Color(0xCC211B2A),
      detailsGlow: Color(0x3D9B7BFF),
      infoCardGradientStart: Color(0xB3211E2C),
      infoCardGradientEnd: Color(0xDB191624),
      infoCardShadow: Color(0x66110D18),
      duaText: Color(0xFFF4EEF9),
      soundCardBackground: Color(0xFF211B2A),
      soundCardBorder: Color(0xFF3E3250),
      soundCardShadow: Color(0x4D000000),
      secondaryText: Color(0xB3D9D2E4),
      divider: Color(0x807E648E),
      headerTitle: Color(0xFFE4D7FF),
      headerSubtitle: Color(0xFFB7AAC7),
      acceptanceBorder: Color(0xAA9E7C4D),
      acceptanceGradientStart: Color(0xCC4E3A21),
      acceptanceGradientEnd: Color(0xCC352714),
      acceptanceTitle: Color(0xFFF8EDDA),
      liveOverlayStart: Color(0xCC050308),
      liveOverlayEnd: Color(0x4D050308),
      liveWatchButton: Color(0xCC8A6722),
      liveStatusChip: Color(0x80322640),
    ),
  ],
);
