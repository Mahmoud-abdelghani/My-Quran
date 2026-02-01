import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:quran/core/api/api_concumer.dart';
import 'package:quran/core/api/end_points.dart';
import 'package:quran/core/errors/server_exception.dart';
import 'package:quran/features/homescreen/data/models/tafseer_type_model.dart';

part 'tafseer_state.dart';

class TafseerCubit extends Cubit<TafseerState> {
  TafseerCubit(this.api) : super(TafseerInitial());
  ApiConcumer api;
  getTafssersTypes() async {
    try {
      emit(TafseerTypesLoading());
      List<TafseerTypeModel> types = [];
      Box tafseerBox = await Hive.openBox('tafseerBox');
      if (tafseerBox.isEmpty) {
        final List<dynamic> listOfJsons = await api.get(
          EndPoints.fetchTafsserTypes,
        );
        types = List.generate(
          listOfJsons.length,
          (index) => TafseerTypeModel.fromJson(listOfJsons[index]),
        );
        await tafseerBox.addAll(types);
      } else {
        log('tafseer from hive');
        types = tafseerBox.values.toList().cast<TafseerTypeModel>();
      }

      emit(TafseerTypesSuccess(tafseerBooks: types));
    } on ServerException catch (e) {
      emit(TafseerTypesError(message: e.errorModel.errorMessage));
    }
  }
}
