import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  final bool _isPlaying = false;

  Future<void> playAudio(String audioPath) async {
    await _audioPlayer.play(
      AssetSource(audioPath),
    );
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }
}
