import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:quran/core/api/api_concumer.dart';
import 'package:quran/core/errors/server_exception.dart';
import 'package:quran/features/homescreen/data/models/nextday_model.dart';

part 'nextpray_state.dart';

class NextprayCubit extends Cubit<NextprayState> {
  NextprayCubit(this.api) : super(NextprayInitial());
  ApiConcumer api;
  NextdayModel? nextdayModel;
  getTheNext({required String address,required String zone}) async {
    address = address == "مصر" ? "egypt" : address;
    try {
      emit(NextprayLoading());
      final json = await api.get(
        '${DateFormat('yy-MM-dd').format(DateTime.now())}?address=$address&method=5&timezonestring=$zone',
      );
      nextdayModel = NextdayModel.fromJson(json);
      emit(NextpraySuccess());
    } on ServerException catch (e) {
      emit(NextprayError(message: e.errorModel.errorMessage));
    }
  }
}
