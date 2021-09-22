import 'audio_player.dart';

abstract class AudioPlayerListener {
  void onAudioPlayerBufferingUpdate(AudioPlayer ap, bool isBuffered);
  void onAudioPlayerStateChanged(AudioPlayer ap, AudioPlayerState state);
  void onAudioPlayerPositionChanged(AudioPlayer ap);
  void onAudioPlayerCompleted(AudioPlayer ap);
}
