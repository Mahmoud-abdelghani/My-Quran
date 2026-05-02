import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:quran/features/homescreen/data/models/manasik_model.dart';

part 'haj_handler_state.dart';

class HajHandlerCubit extends Cubit<HajHandlerState> {
  HajHandlerCubit() : super(HajHandlerInitial());

  Future<List<dynamic>> getRituals() async {
   
    final String jsonString = await rootBundle.loadString(
      'assets/json/hajj/hajj_rituals.json',
    );

    final Map<String, dynamic> decoded = json.decode(jsonString);

    return decoded['rituals'];
  }

  Future<void> getRitualData() async {
    try {
      emit(HajHandlerLoading());
      List<dynamic> rituals = await getRituals();
      List<ManasikModel> manasikList = rituals
          .map((ritual) => ManasikModel.fromJson(ritual))
          .toList();
      emit(HajHandlerSuccess(manasikList));
    } on Exception catch (e) {
      emit(HajHandlerError(e.toString()));
    }
  }
}
