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
      dayDate: json[ApiKeys.data][ApiKeys.date][ApiKeys.readable],
      month:
          json[ApiKeys.data][ApiKeys.date][ApiKeys.hijri][ApiKeys.month][ApiKeys
              .en],
      date: json[ApiKeys.data][ApiKeys.date][ApiKeys.hijri][ApiKeys.date],
      nextPray: json[ApiKeys.data][ApiKeys.timings],
    );
  }
}
