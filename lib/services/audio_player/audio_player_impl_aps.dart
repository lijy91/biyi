import 'dart:async';

import 'package:audioplayers/audioplayers.dart' as aps;

import 'audio_player.dart';

class AudioPlayerImplAPS extends AudioPlayer {
  aps.AudioPlayer _apsPlayer = aps.AudioPlayer();

  Uri _audioUrl;
  Duration _currentPosition = Duration.zero;
  Duration _duration = Duration.zero;
  AudioPlayerState _state = AudioPlayerState.initialized;

  AudioPlayerImplAPS(int id) {
    _apsPlayer.onPlayerStateChanged.listen((aps.PlayerState s) {
      switch (s) {
        case aps.PlayerState.PLAYING:
          _state = AudioPlayerState.playing;
          break;
        case aps.PlayerState.PAUSED:
          _state = AudioPlayerState.paused;
          break;
        default:
      }
      listeners.forEach((listener) {
        listener.onAudioPlayerStateChanged(this, _state);
      });
    });
    _apsPlayer.onPlayerCompletion.listen((_) {
      _state = AudioPlayerState.completed;
      listeners.forEach((listener) {
        listener.onAudioPlayerCompleted(this);
      });
    });
    _apsPlayer.onAudioPositionChanged.listen((Duration position) {
      _currentPosition = position;
      _state = AudioPlayerState.playing;
      listeners.forEach((listener) {
        listener.onAudioPlayerPositionChanged(this);
      });
    });
    _apsPlayer.onDurationChanged.listen((Duration duration) {
      _duration = duration;
    });
  }

  Uri getSource() {
    return _audioUrl;
  }

  Future<void> setSource(Uri url) {
    _audioUrl = url;
    return Future.value();
  }

  Future<void> prepare() {
    return Future.value();
  }

  Future<void> start() {
    _apsPlayer.play(_audioUrl.toString());
    return Future.value();
  }

  Future<void> stop() {
    _apsPlayer.seek(Duration(milliseconds: 0));
    _apsPlayer.stop();
    return Future.value();
  }

  Future<void> pause() {
    _apsPlayer.pause();
    return Future.value();
  }

  Future<void> seekTo(Duration duration) {
    _apsPlayer.seek(duration);
    return Future.value();
  }

  Future<void> release() {
    _apsPlayer.dispose();
    return Future.value();
  }

  Duration getCurrentPosition() {
    return _currentPosition;
  }

  Duration getDuration() {
    return _duration;
  }
}
