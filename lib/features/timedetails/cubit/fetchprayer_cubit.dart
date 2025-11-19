
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:quran/core/api/api_concumer.dart';
import 'package:quran/core/errors/server_exception.dart';
import 'package:quran/features/timedetails/data/models/prayers_times_model.dart';

part 'fetchprayer_state.dart';

class FetchprayerCubit extends Cubit<FetchprayerState> {
  FetchprayerCubit(this.api) : super(FetchprayerInitial());
  ApiConcumer api;
  List<String> timesIcons = [
    "assets/images/cloudy-night.png",
    "assets/images/cloud-computing 1.png",
    "assets/images/sunrise (1).png",
  ];
  List<String> prayers = ["Fajr", "Sunrise", "Dhuhr", "Asr", "Maghrib", "Isha"];
  getPrayers({required String city, required String country}) async {
    try {
      emit(FetchprayerLoading());
      final response = await api.get(
        '${DateFormat('yy-MM-dd').format(DateTime.now())}?city=$city&country=$country&method=5&timezonestring=Africa/Cairo',
      );
      emit(FetchprayerSuccess(prayers: PrayersTimesModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(FetchprayerError(message: e.errorModel.errorMessage));
    }
  }
}
