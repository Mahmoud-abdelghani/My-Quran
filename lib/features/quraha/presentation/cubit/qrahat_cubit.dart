import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran/core/api/api_concumer.dart';
import 'package:quran/core/api/end_points.dart';
import 'package:quran/features/surahdetails/data/models/shek_model.dart';

part 'qrahat_state.dart';

class QrahatCubit extends Cubit<QrahatState> {
  QrahatCubit(this.api) : super(QrahatInitial());

  ApiConcumer api;
  int? suraIndex;
  List<ShekModel>? sheook;
  List<String>? namesForSearch;
  Future<void> fetchQuraat({required int surahNum}) async {
    try {
      suraIndex = surahNum;
      emit(QraaLoading());
      final allQuraaResponse = await api.get(EndPoints.fetchAllSheook);
      final allQuraaResponseEn = await api.get(
        '${EndPoints.fetchAllSheook}?language=en',
      );
      String numToSend;

      if (surahNum ~/ 10.toInt() == 0) {
        numToSend = "00$surahNum";
      } else if (surahNum ~/ 100.toInt() == 0) {
        numToSend = '0$surahNum';
      } else {
        numToSend = "$surahNum";
      }

      List<dynamic> listOfSheekEn = allQuraaResponseEn[ApiKeys.reciters] ?? [];
      List<dynamic> listOfSheek = allQuraaResponse[ApiKeys.reciters] ?? [];

      List<ShekModel> shekModelsEn = List.generate(
        listOfSheekEn.length,
        (index) => ShekModel.fromholyJson(listOfSheekEn[index], numToSend),
      );
      List<ShekModel> shekModels = List.generate(
        listOfSheek.length,
        (index) => ShekModel.fromholyJson(listOfSheek[index], numToSend),
      );
      log(shekModels.length.toString());
      log(shekModelsEn.length.toString());
      sheook = shekModels;
      namesForSearch = List.generate(
        shekModels.length,
        (index) => shekModels[index].name,
      );
      namesForSearch!.addAll(
        List.generate(shekModelsEn.length, (index) => shekModelsEn[index].name),
      );
      sheook!.addAll(shekModelsEn);
      emit(QraaSuccess());
    } on Exception catch (e) {
      emit(QraaError(message: e.toString()));
    }
  }
}
