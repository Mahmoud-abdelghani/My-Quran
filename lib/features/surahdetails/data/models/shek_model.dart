import 'package:quran/core/api/end_points.dart';

class ShekModel {
  final String name;
  final String originalUrl;
  ShekModel({required this.name, required this.originalUrl});
  factory ShekModel.fromJson(Map<String, dynamic> json) {
    return ShekModel(name: json[ApiKeys.reciter],originalUrl: json[ApiKeys.originalUrl]);
  }
}
