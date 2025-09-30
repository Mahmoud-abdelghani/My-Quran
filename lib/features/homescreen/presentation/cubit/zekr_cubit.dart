import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran/core/api/api_concumer.dart';
import 'package:quran/core/api/end_points.dart';
import 'package:quran/core/errors/server_exception.dart';
import 'package:quran/features/homescreen/data/models/azkar_model.dart';

part 'zekr_state.dart';

class ZekrCubit extends Cubit<ZekrState> {
  ZekrCubit(this.api) : super(ZekrInitial());
  ApiConcumer api;
  AzkarModel? azkarsappah;
  AzkarModel? azkarmassa;
  getAzkar() async {
    try {
      emit(ZekrLoading());
      final jsonSappah = await api.get(EndPoints.fetchAzkarElSappah);
      azkarsappah = AzkarModel.fromJson(jsonSappah);
      final jsonMassa = await api.get(EndPoints.fetchAzkarElmassa);
      azkarmassa = AzkarModel.fromJson(jsonMassa);
      emit(ZekrSuccess());
    } on ServerException catch (e) {
      emit(ZekrError(message: e.errorModel.errorMessage));
    }
  }
}
