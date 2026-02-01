import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:quran/core/api/api_concumer.dart';
import 'package:quran/core/api/end_points.dart';
import 'package:quran/core/errors/server_exception.dart';
import 'package:quran/features/surahdetails/data/models/full_surah_model.dart';
import 'package:quran/features/surahdetails/data/models/shek_model.dart';

part 'full_surah_state.dart';

class FullSurahCubit extends Cubit<FullSurahState> {
  FullSurahCubit(this.api) : super(FullSurahInitial());
  ApiConcumer api;
  FullSurahModel? fullSurahModel;
  getFullSurah(int surahNum) async {
    try {
      emit(FullSurahLoading());
      Box surhBox = await Hive.openBox('surahBox');
      if (surhBox.containsKey('surah$surahNum')) {
        fullSurahModel = surhBox.get('surah$surahNum') as FullSurahModel;
        log('details from hive');
      } else {
        final json = await api.get("api/$surahNum.json");
        fullSurahModel = FullSurahModel.fromJson(json);
        surhBox.put('surah$surahNum', fullSurahModel);
      }

      emit(FullSurahSuccess(fullSurahModel: fullSurahModel!));
    } on ServerException catch (e) {
      emit(FullSurahconnectionError(message: e.errorModel.errorMessage));
    }
  }
}

//https://server7.mp3quran.net/basit/114.mp3
//عبدالباسط عبدالصمد
extension ArabicNumbers on int {
  String toArabicDigits() {
    const arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return toString().split('').map((e) => arabicNumbers[int.parse(e)]).join();
  }
}
