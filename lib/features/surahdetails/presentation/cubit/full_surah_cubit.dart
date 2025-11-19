import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran/core/api/api_concumer.dart';
import 'package:quran/core/errors/server_exception.dart';
import 'package:quran/features/surahdetails/data/models/full_surah_model.dart';
import 'package:quran/features/surahdetails/data/models/shek_model.dart';

part 'full_surah_state.dart';

class FullSurahCubit extends Cubit<FullSurahState> {
  FullSurahCubit(this.api) : super(FullSurahInitial());
  ApiConcumer api;
  FullSurahModel? fullSurahModel;
  getFullSurah(int surahNum) async {
    String numToSend = "";
    try {
      emit(FullSurahLoading());
      final json = await api.get("api/$surahNum.json");
      fullSurahModel = FullSurahModel.fromJson(json);

      if (surahNum ~/ 10.toInt() == 0) {
        numToSend = "00$surahNum";
      } else if (surahNum ~/ 100.toInt() == 0) {
        numToSend = '0$surahNum';
      } else {
        numToSend = "$surahNum";
      }

      fullSurahModel!.mashaih.add(
        ShekModel(
          name: "Saud El shorem",
          originalUrl: "https://server7.mp3quran.net/shur/64/$numToSend.mp3",
        ),
      );
      fullSurahModel!.mashaih.add(
        ShekModel(
          name: "Abdul Basit Abdul Samad",
          originalUrl: "https://server7.mp3quran.net/basit/$numToSend.mp3",
        ),
      );
      fullSurahModel!.mashaih.add(
        ShekModel(
          name: "Ahmed bin Ali Al-Ajmi",
          originalUrl: "https://server10.mp3quran.net/ajm/$numToSend.mp3",
        ),
      );
      emit(FullSurahSuccess(fullSurahModel: fullSurahModel!));
    } on ServerException catch (e) {
      emit(FullSurahconnectionError(message: e.errorModel.errorMessage));
    }
  }
}

//https://server7.mp3quran.net/basit/114.mp3
//عبدالباسط عبدالصمد
