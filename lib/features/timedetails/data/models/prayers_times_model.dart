import 'package:quran/core/api/end_points.dart';
import 'package:quran/features/timedetails/data/models/pray_model.dart';

class PrayersTimesModel {
  final List<PrayModel> prayers;
  final String dayDate;
  PrayersTimesModel({required this.prayers, required this.dayDate});
  factory PrayersTimesModel.fromJson(Map<String, dynamic> json) {
    return PrayersTimesModel(
      dayDate: json[apiKeys.data][apiKeys.date][apiKeys.readable],
      prayers: List.generate(json[apiKeys.data][apiKeys.timings].length, (
        index,
      ) {
        return PrayModel.fromJson({
          json[apiKeys.data][apiKeys.timings].entries
              .elementAt(index)
              .key: json[apiKeys.data][apiKeys.timings].entries
              .elementAt(index)
              .value,
        });
      }),
    );
  }
}
