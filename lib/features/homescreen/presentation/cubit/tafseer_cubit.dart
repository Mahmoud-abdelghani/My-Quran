import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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
      final List<dynamic> listOfJsons = await api.get(
        EndPoints.fetchTafsserTypes,
      );
      List<TafseerTypeModel> types = List.generate(
        listOfJsons.length,
        (index) => TafseerTypeModel.fromJson(listOfJsons[index]),
      );
      emit(TafseerTypesSuccess(tafseerBooks: types));
    } on ServerException catch (e) {
      emit(TafseerTypesError(message: e.errorModel.errorMessage));
    }
  }
}
