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
  late String urlGeneral;

  playAudio(String url) async {
    urlGeneral = url;
    await player.play(UrlSource(url));
    duration = await player.getDuration() ?? Duration(seconds: 2);
    isPlaying = true;
    firstTime = false;
    emit(AudioPlayerPlaying());
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
    playAudio(urlGeneral);
  }
}
