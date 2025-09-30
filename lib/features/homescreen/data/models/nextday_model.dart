import 'package:quran/core/api/end_points.dart';

class NextdayModel {
  final String date;
  final String month;
  final String dayDate;
  final Map<String, dynamic> nextPray;
  NextdayModel({
    required this.dayDate,
    required this.date,
    required this.nextPray,
    required this.month,
  });
  factory NextdayModel.fromJson(Map<String, dynamic> json) {
    return NextdayModel(
      dayDate: json[apiKeys.data][apiKeys.date][apiKeys.readable],
      month:
          json[apiKeys.data][apiKeys.date][apiKeys.hijri][apiKeys.month][apiKeys
              .en],
      date: json[apiKeys.data][apiKeys.date][apiKeys.hijri][apiKeys.date],
      nextPray: json[apiKeys.data][apiKeys.timings],
    );
  }
}
