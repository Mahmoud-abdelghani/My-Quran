import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
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
  bool? isUrl;

  playAudio(String url, String currenQaree) async {
    try {
      log(currenQaree);
      isUrl = true;
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
    isPlaying = true;

    player.resume();
  }

  String? generalKey;
  bool firstTimedwonload = true;
  Future<void> playDownloadedAudio(String key, String qareeName) async {
    try {
      firstTimedwonload = false;
      isUrl = false;
      generalKey = key;
      final Box audioBox = await Hive.openBox('audioBox');

      final Uint8List audioBytes = audioBox.get(key) as Uint8List;

      await player.play(BytesSource(audioBytes));
      duration = await player.getDuration() ?? Duration(seconds: 2);
      isPlaying = true;
      firstTime = false;
      qaree = qareeName;
      emit(AudioPlayerPlaying());
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
