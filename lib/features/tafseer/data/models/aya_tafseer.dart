import 'package:quran/core/api/end_points.dart';

class AyaTafseer {
  final String ayaNum;
  final String aya;
  final String text;
  
  AyaTafseer( {required this.ayaNum, required this.text,required this.aya});
  factory AyaTafseer.fromJson(Map<String, dynamic> jsonTafseer,Map<String ,dynamic> jsonAya) {
    return AyaTafseer(
      ayaNum: jsonTafseer[ApiKeys.ayahNumber].toString(),
      text: jsonTafseer[ApiKeys.text],
      aya:jsonAya[ApiKeys.text]
    );
  }
}
