import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:quran/core/api/api_concumer.dart';
import 'package:quran/core/api/end_points.dart';
import 'package:quran/core/errors/server_exception.dart';
import 'package:quran/features/homescreen/data/models/surah_model.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit(this.api) : super(QuranInitial());
  ApiConcumer api;
  List<SurahModel> surs = [];
  fetchQuran() async {
    try {
      emit(QuranFetchingLoading());
      Box quranBox = await Hive.openBox('QuranBox');

      if (quranBox.isEmpty) {
        final list = await api.get(EndPoints.fetchChapters);
        for (var element in list) {
          surs.add(SurahModel.fromJson(element));
        }
        await quranBox.addAll(surs);
      } else {
        log('Surahs from hive!');
        for (int i = 0; i < quranBox.length; i++) {
          surs.add(quranBox.getAt(i));
        }
      }

      emit(QuranFetchingSuccess());
    } on ServerException catch (e) {
      emit(QuranFetchingError(message: e.errorModel.errorMessage));
    }
  }
}
