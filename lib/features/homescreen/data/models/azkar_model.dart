import 'package:quran/core/api/end_points.dart';
import 'package:quran/features/homescreen/data/models/zekr_model.dart';

class AzkarModel {
  final String type;
  final List<ZekrModel> azkar;
  AzkarModel({required this.azkar, required this.type});
  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    return AzkarModel(
      azkar: List.generate(
        json[apiKeys.content].length,
        (index) => ZekrModel.fromJson(json[apiKeys.content][index]),
      ),
      type: json[apiKeys.title],
    );
  }
}
