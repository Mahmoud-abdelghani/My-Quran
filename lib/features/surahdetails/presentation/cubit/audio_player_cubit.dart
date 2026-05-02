import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
// ignore: unnecessary_import
import 'package:meta/meta.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit() : super(AudioPlayerInitial());
  final AudioPlayer player = AudioPlayer();
  final AudioPlayer playerTak = AudioPlayer();
  final AudioPlayer playerTal = AudioPlayer();
  bool? isPlaying = false;
  bool? isPlayingTak = false;
  bool? isPlayingTal = false;
  bool firstTime = true;
  Duration duration = Duration(seconds: 0);

  // ✅ Looping state for each player
  bool isTakLooping = false;
  bool isTalLooping = false;

  String? urlGeneral;
  String qaree = "Yasser Al Dosari";
  bool? isUrl;

  playAudio(String url, String currenQaree) async {
    try {
      isUrl = true;
      urlGeneral = url;
      await player.play(UrlSource(url));
      duration = await player.getDuration() ?? Duration(seconds: 2);
      isPlaying = true;
      isPlayingTak = false;
      isPlayingTal = false;
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

  playAudiotakber(String url, String currenQaree) async {
    try {
      emit(AudioPlayerTakLoading());
      isUrl = true;
      urlGeneral = url;
      await playerTak.play(UrlSource(url));

      // ✅ Apply looping mode if enabled
      await playerTak.setReleaseMode(
        isTakLooping ? ReleaseMode.loop : ReleaseMode.release,
      );

      isPlayingTak = true;
      isPlayingTal = false;
      isPlaying = false;
      firstTime = false;
      qaree = currenQaree;
      emit(AudioPlayerPlaying());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  playAudiotalbia(String url, String currenQaree) async {
    try {
      emit(AudioPlayerTalLoading());
      isUrl = true;
      urlGeneral = url;
      await playerTal.play(UrlSource(url));

      // ✅ Apply looping mode if enabled
      await playerTal.setReleaseMode(
        isTalLooping ? ReleaseMode.loop : ReleaseMode.release,
      );

      isPlayingTal = true;
      isPlayingTak = false;
      isPlaying = false;
      firstTime = false;
      qaree = currenQaree;
      emit(AudioPlayerPlaying());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  pauseAudioTakber() {
    playerTak.stop();
    isPlayingTak = false;
    emit(AudioPlayerStop());
  }

  pauseAudioTalbia() {
    playerTal.stop();
    isPlayingTal = false;
    emit(AudioPlayerStop());
  }

  // ✅ Toggle looping for Takbeer
  Future<void> toggleTakLooping() async {
    isTakLooping = !isTakLooping;
    await playerTak.setReleaseMode(
      isTakLooping ? ReleaseMode.loop : ReleaseMode.release,
    );
    emit(AudioPlayerPlaying());
  }

  // ✅ Toggle looping for Talbia
  Future<void> toggleTalLooping() async {
    isTalLooping = !isTalLooping;
    await playerTal.setReleaseMode(
      isTalLooping ? ReleaseMode.loop : ReleaseMode.release,
    );
    emit(AudioPlayerPlaying());
  }
}
