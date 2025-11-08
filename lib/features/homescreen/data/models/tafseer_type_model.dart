import 'package:quran/core/api/end_points.dart';

class TafseerTypeModel {
  final String id;
  final String name;
  final String language;
  final String bookName;
  final String author;
  TafseerTypeModel({
    required this.author,
    required this.id,
    required this.bookName,
    required this.language,
    required this.name,
  });
  factory TafseerTypeModel.fromJson(Map<String, dynamic> json) {
    return TafseerTypeModel(
      author: json[apiKeys.author],
      id: json[apiKeys.id].toString(),
      bookName: json[apiKeys.bookName],
      language: json[apiKeys.language]=='ar'?'الْعَرَبِيَّةُ':json[apiKeys.language]=='en'?'English':'Dutch',
      name: json[apiKeys.name],
    );
  }
}
