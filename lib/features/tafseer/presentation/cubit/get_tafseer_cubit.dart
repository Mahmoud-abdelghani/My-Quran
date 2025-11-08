import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:quran/core/api/api_concumer.dart';
import 'package:quran/core/api/end_points.dart';
import 'package:quran/core/errors/server_exception.dart';
import 'package:quran/features/tafseer/data/models/aya_tafseer.dart';

part 'get_tafseer_state.dart';

class GetTafseerCubit extends Cubit<GetTafseerState> {
  GetTafseerCubit(this.api) : super(GetTafseerInitial());
  ApiConcumer api;
  fetchFullSurahTafseer({
    required String tafseerId,
    required String surahNum,
    required int from,
    required int to,
  }) async {
    try {
      emit(GetTafseerLoading());
      final List<dynamic> listOfAyat = await api.get(
        '${EndPoints.fetchTafsserTypes}/$tafseerId/$surahNum/$from/$to',
      );
      final List<dynamic> listOfAyatsUrl = [];
      for (var element in listOfAyat) {
        final json = await api.get(element['ayah_url']);
        listOfAyatsUrl.add(json);
      }
      List<AyaTafseer> listOfTafseers = List.generate(
        listOfAyat.length,
        (index) =>
            AyaTafseer.fromJson(listOfAyat[index], listOfAyatsUrl[index]),
      );
      emit(GetTafseerSuccess(tafseerOfAyats: listOfTafseers));
    } on ServerException catch (e) {
      emit(GetTafseerError(error: e.errorModel.errorMessage));
    }
  }
}
