import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit() : super(AudioPlayerInitial());
  final AudioPlayer player = AudioPlayer();
  bool? isPlaying = false;
  bool firstTime = true;
  Duration duration = Duration(seconds: 0);
  String? urlGeneral;
  String qaree = "Yasser Al Dosari";

  playAudio(String url, String currenQaree) async {
    try {
      urlGeneral = url;
      await player.play(UrlSource(url));
      duration = await player.getDuration() ?? Duration(seconds: 2);
      isPlaying = true;
      firstTime = false;
      qaree = currenQaree;
      emit(AudioPlayerPlaying());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  pauseAudio() {
    player.pause();
    isPlaying = false;
    emit(AudioPlayerStop());
  }

  changeFirstTime() {
    firstTime = true;
  }

  resume() {
    playAudio(urlGeneral!, qaree);
  }
}
