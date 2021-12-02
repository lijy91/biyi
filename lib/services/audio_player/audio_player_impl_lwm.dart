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
      for (var listener in listeners) {
        listener.onAudioPlayerStateChanged(this, _state);
      }
    });
    _lwmPlayer.streams.isBuffering.listen((bool isBuffering) {
      if (isBuffering) {
        _state = AudioPlayerState.buffering;
      }
      for (var listener in listeners) {
        listener.onAudioPlayerBufferingUpdate(this, !isBuffering);
      }
    });
    _lwmPlayer.streams.isCompleted.listen((bool isCompleted) {
      if (!isCompleted) return;
      _state = AudioPlayerState.completed;
      for (var listener in listeners) {
        listener.onAudioPlayerCompleted(this);
      }
    });
    _lwmPlayer.streams.position.listen((Duration position) {
      _state = AudioPlayerState.playing;
      for (var listener in listeners) {
        listener.onAudioPlayerPositionChanged(this);
      }
    });
    _lwmPlayer.streams.duration.listen((Duration duration) {});
    _lwmPlayer.streams.index.listen((int index) {});
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
    _lwmPlayer.open([lwm.Media(uri: _audioUrl.toString())]);
    return Future.value();
  }

  @override
  Future<void> start() {
    if (_lwmPlayer.state.isCompleted) {
      _lwmPlayer.seek(const Duration(milliseconds: 0));
    }
    _lwmPlayer.play();
    return Future.value();
  }

  @override
  Future<void> stop() {
    _lwmPlayer.pause();
    _lwmPlayer.seek(const Duration(milliseconds: 0));
    return Future.value();
  }

  @override
  Future<void> pause() {
    _lwmPlayer.pause();
    return Future.value();
  }

  @override
  Future<void> seekTo(Duration duration) {
    _lwmPlayer.seek(duration);
    return Future.value();
  }

  @override
  Future<void> release() {
    _lwmPlayer.dispose();
    return Future.value();
  }

  @override
  Duration getCurrentPosition() {
    return _lwmPlayer.state.position;
  }

  @override
  Duration getDuration() {
    return _lwmPlayer.state.duration;
  }
}
