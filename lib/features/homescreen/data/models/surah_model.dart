import 'package:quran/core/api/end_points.dart';

class SurahModel {
  final String nameInEn;
  final String nameInAr;
  final String place;
  final int ayatnum;
  SurahModel({
    required this.nameInEn,
    required this.nameInAr,
    required this.ayatnum,
    required this.place,
  });
  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      nameInEn: json[ApiKeys.surahName],
      nameInAr: json[ApiKeys.surahNameArabic],
      ayatnum: json[ApiKeys.totalAyah],
      place: json[ApiKeys.revelationPlace],
    );
  }
}
