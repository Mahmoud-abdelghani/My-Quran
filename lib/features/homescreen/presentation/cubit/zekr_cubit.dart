import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
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
      Box sabahBox = await Hive.openBox('Sabah');
      Box messaBox = await Hive.openBox('Messa');
      if (sabahBox.isEmpty) {
        final jsonSappah = await api.get(EndPoints.fetchAzkarElSappah);
        azkarsappah = AzkarModel.fromJson(jsonSappah);
        sabahBox.put('type', azkarsappah!.type);
        sabahBox.addAll(azkarsappah!.azkar);
      } else {
        log('Sapah Hive');
        azkarsappah = AzkarModel(azkar: [], type: await sabahBox.get('type'));
        for (int i = 0; i < sabahBox.length; i++) {
          if (i < 31) {
            azkarsappah!.azkar.add(await sabahBox.getAt(i));
          }
        }
      }

      if (messaBox.isEmpty) {
        final jsonMassa = await api.get(EndPoints.fetchAzkarElmassa);
        azkarmassa = AzkarModel.fromJson(jsonMassa);
        messaBox.put('type', azkarmassa!.type);
        messaBox.addAll(azkarmassa!.azkar);
      } else {
        log('messa hive');
        azkarmassa = AzkarModel(azkar: [], type: await messaBox.get('type'));
        for (int i = 0; i < messaBox.length - 1; i++) {
          azkarmassa!.azkar.add(await messaBox.getAt(i));
        }
      }

      emit(ZekrSuccess());
    } on ServerException catch (e) {
      emit(ZekrError(message: e.errorModel.errorMessage));
    }
  }
}
