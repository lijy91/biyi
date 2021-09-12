import 'package:audio_player/audio_player.dart';

export 'package:audio_player/audio_player.dart';

class AudioPlayerService {
  AudioPlayerService._();

  /// The shared instance of [AudioPlayerService].
  static final AudioPlayerService instance = AudioPlayerService._();

  final AudioPlayer _audioPlayer =
      AudioPlayer.create(DateTime.now().millisecond);
  String _lastPlayAudioUrl;

  bool get hasListeners {
    return _audioPlayer.hasListeners;
  }

  void addListener(AudioPlayerListener listener) {
    _audioPlayer.addListener(listener);
  }

  void removeListener(AudioPlayerListener listener) {
    _audioPlayer.removeListener(listener);
  }

  Future<void> play(String audioUrl) async {
    _lastPlayAudioUrl = audioUrl;

    await _audioPlayer.setSource(Uri.parse(audioUrl));
    await _audioPlayer.prepare();
    await _audioPlayer.start();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  String get lastPlayAudioUrl => _lastPlayAudioUrl;
}
