import 'package:quran/core/api/end_points.dart';
import 'package:quran/features/timedetails/data/models/pray_model.dart';

class PrayersTimesModel {
  final List<PrayModel> prayers;
  final String dayDate;
  PrayersTimesModel({required this.prayers, required this.dayDate});
  factory PrayersTimesModel.fromJson(Map<String, dynamic> json) {
    return PrayersTimesModel(
      dayDate: json[ApiKeys.data][ApiKeys.date][ApiKeys.readable],
      prayers: List.generate(json[ApiKeys.data][ApiKeys.timings].length, (
        index,
      ) {
        return PrayModel.fromJson({
          json[ApiKeys.data][ApiKeys.timings].entries
              .elementAt(index)
              .key: json[ApiKeys.data][ApiKeys.timings].entries
              .elementAt(index)
              .value,
        });
      }),
    );
  }
}
