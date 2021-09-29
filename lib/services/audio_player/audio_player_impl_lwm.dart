import 'dart:async';
import 'dart:io';

// ignore: unused_import
import 'package:libwinmedia/libwinmedia.dart'
    if (dart.library.html) 'libwinmedia_noop.dart' as lwm;

import 'audio_player.dart';

class AudioPlayerImplLWM extends AudioPlayer {
  static void initialize() {
    if (Platform.isWindows || Platform.isLinux) {
      lwm.LWM.initialize();
    }
  }

  lwm.Player _lwmPlayer;
  Uri _audioUrl;
  AudioPlayerState _state = AudioPlayerState.initialized;

  AudioPlayerImplLWM(int id) {
    _lwmPlayer = lwm.Player(id: id);
    _lwmPlayer.streams.medias.listen((List<lwm.Media> medias) {});
    _lwmPlayer.streams.isPlaying.listen((bool isPlaying) {
      _state = isPlaying ? AudioPlayerState.playing : AudioPlayerState.paused;
      listeners.forEach((listener) {
        listener.onAudioPlayerStateChanged(this, _state);
      });
    });
    _lwmPlayer.streams.isBuffering.listen((bool isBuffering) {
      if (isBuffering) {
        _state = AudioPlayerState.buffering;
      }
      listeners.forEach((listener) {
        listener.onAudioPlayerBufferingUpdate(this, !isBuffering);
      });
    });
    _lwmPlayer.streams.isCompleted.listen((bool isCompleted) {
      if (!isCompleted) return;
      _state = AudioPlayerState.completed;
      listeners.forEach((listener) {
        listener.onAudioPlayerCompleted(this);
      });
    });
    _lwmPlayer.streams.position.listen((Duration position) {
      _state = AudioPlayerState.playing;
      listeners.forEach((listener) {
        listener.onAudioPlayerPositionChanged(this);
      });
    });
    _lwmPlayer.streams.duration.listen((Duration duration) {});
    _lwmPlayer.streams.index.listen((int index) {});
  }

  Uri getSource() {
    return _audioUrl;
  }

  Future<void> setSource(Uri url) {
    _audioUrl = url;
    return Future.value();
  }

  Future<void> prepare() {
    _lwmPlayer.open([lwm.Media(uri: _audioUrl.toString())]);
    return Future.value();
  }

  Future<void> start() {
    if (_lwmPlayer.state.isCompleted) {
      _lwmPlayer.seek(Duration(milliseconds: 0));
    }
    _lwmPlayer.play();
    return Future.value();
  }

  Future<void> stop() {
    _lwmPlayer.pause();
    _lwmPlayer.seek(Duration(milliseconds: 0));
    return Future.value();
  }

  Future<void> pause() {
    _lwmPlayer.pause();
    return Future.value();
  }

  Future<void> seekTo(Duration duration) {
    _lwmPlayer.seek(duration);
    return Future.value();
  }

  Future<void> release() {
    _lwmPlayer.dispose();
    return Future.value();
  }

  Duration getCurrentPosition() {
    return _lwmPlayer.state.position;
  }

  Duration getDuration() {
    return _lwmPlayer.state.duration;
  }
}
