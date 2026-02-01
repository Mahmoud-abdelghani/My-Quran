import 'package:quran/core/api/end_points.dart';
import 'package:quran/features/surahdetails/data/models/shek_model.dart';

class FullSurahModel {
  final String name;
  final String translation;
  final List<dynamic> ayatInAr;
  final List<dynamic> ayatInEn;
  final List<ShekModel> mashaih;
  FullSurahModel({
    required this.translation,
    required this.mashaih,
    required this.name,
    required this.ayatInAr,
    required this.ayatInEn,
  });
  factory FullSurahModel.fromJson(Map<String, dynamic> json) {
    return FullSurahModel(
      mashaih: List.generate(
        5,
        (index) => ShekModel.fromJson(json[ApiKeys.audio]['${index + 1}']),
      ),
      name: json[ApiKeys.surahName],
      ayatInAr: json[ApiKeys.arabic1],
      ayatInEn: json[ApiKeys.english],
      translation: json[ApiKeys.revelationPlace],
    );
  }
  set ayatInAr(List<dynamic> value) {
    ayatInAr = value;
  }
}
