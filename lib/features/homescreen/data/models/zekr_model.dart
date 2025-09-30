import 'package:quran/core/api/end_points.dart';

class ZekrModel {
  final String zekr;
  final int count;
  final String bless;
  ZekrModel({required this.bless, required this.count, required this.zekr});
  factory ZekrModel.fromJson(Map<String, dynamic> json) {
    return ZekrModel(
      bless: json[apiKeys.bless],
      count: json[apiKeys.repeat],
      zekr: json[apiKeys.zekr],
    );
  }
}
