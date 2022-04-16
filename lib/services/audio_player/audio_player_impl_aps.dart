import 'dart:async';

import 'package:audioplayers/audioplayers.dart' as aps;

import 'audio_player.dart';

class AudioPlayerImplAPS extends AudioPlayer {
  final aps.AudioPlayer _apsPlayer = aps.AudioPlayer();

 late Uri _audioUrl;
 late Duration _currentPosition = Duration.zero;
 late Duration _duration = Duration.zero;
 late AudioPlayerState _state = AudioPlayerState.initialized;

  AudioPlayerImplAPS(int id) {
    _apsPlayer.onPlayerStateChanged.listen((aps.PlayerState s) {
      switch (s) {
        case aps.PlayerState.PLAYING:
          _state = AudioPlayerState.playing;
          break;
        case aps.PlayerState.PAUSED:
          _state = AudioPlayerState.paused;
          break;
        case aps.PlayerState.COMPLETED:
          _state = AudioPlayerState.completed;
          break;
        default:
      }
      for (var listener in listeners) {
        listener.onAudioPlayerStateChanged(this, _state);
      }
    });
    _apsPlayer.onPlayerCompletion.listen((_) {
      _state = AudioPlayerState.completed;
      for (var listener in listeners) {
        listener.onAudioPlayerCompleted(this);
      }
    });
    _apsPlayer.onAudioPositionChanged.listen((Duration position) {
      _currentPosition = position;
      _state = AudioPlayerState.playing;
      for (var listener in listeners) {
        listener.onAudioPlayerPositionChanged(this);
      }
    });
    _apsPlayer.onDurationChanged.listen((Duration duration) {
      _duration = duration;
    });
  }

  @override
  Uri getSource() {
    return _audioUrl;
  }

  @override
  Future<void> setSource(Uri url) {
    _audioUrl = url;
    return Future.value();
  }

  @override
  Future<void> prepare() {
    return Future.value();
  }

  @override
  Future<void> start() {
    _apsPlayer.play(_audioUrl.toString());
    return Future.value();
  }

  @override
  Future<void> stop() {
    _apsPlayer.seek(const Duration(milliseconds: 0));
    _apsPlayer.stop();
    return Future.value();
  }

  @override
  Future<void> pause() {
    _apsPlayer.pause();
    return Future.value();
  }

  @override
  Future<void> seekTo(Duration duration) {
    _apsPlayer.seek(duration);
    return Future.value();
  }

  @override
  Future<void> release() {
    _apsPlayer.dispose();
    return Future.value();
  }

  @override
  Duration getCurrentPosition() {
    return _currentPosition;
  }

  @override
  Duration getDuration() {
    return _duration;
  }
}
