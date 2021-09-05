import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/foundation.dart';
// ignore: unused_import
import 'package:dart_vlc/dart_vlc.dart'
    if (dart.library.html) '../../utilities/dart_vlc_noop.dart' as vlc;

import '../../includes.dart';

export 'package:audioplayers/audioplayers.dart';

const kMethodOnPlayerStateChanged = 'onPlayerStateChanged';

abstract class AudioPlayerListener {
  void onPlayerStateChanged(String audioUrl, PlayerState playerState);
}

class AudioPlayerService {
  AudioPlayerService._();

  /// The shared instance of [AudioPlayerService].
  static final AudioPlayerService instance = AudioPlayerService._();

  final AudioPlayer _audioPlayer = AudioPlayer();
  vlc.Player _vlcPlayer;

  final ObserverList<AudioPlayerListener> _listeners =
      ObserverList<AudioPlayerListener>();

  bool _inited = false;
  String _lastPlayAudioUrl;

  bool _debugAssertNotDisposed() {
    assert(() {
      if (_listeners == null) {
        throw FlutterError('A $runtimeType was used after being disposed.\n'
            'Once you have called dispose() on a $runtimeType, it can no longer be used.');
      }
      return true;
    }());
    return true;
  }

  bool get hasListeners {
    assert(_debugAssertNotDisposed());
    return _listeners.isNotEmpty;
  }

  void addListener(AudioPlayerListener listener) {
    assert(_debugAssertNotDisposed());
    _listeners.add(listener);
  }

  void removeListener(AudioPlayerListener listener) {
    assert(_debugAssertNotDisposed());
    _listeners.remove(listener);
  }

  void _init() {
    if (_inited) return;
    if (kIsWeb) {
      _audioPlayer.onPlayerStateChanged.listen(_listenPlayerStateChanged);
    } else {
      _vlcPlayer = vlc.Player(id: 69420);
      _vlcPlayer.playbackStream.listen((vlc.PlaybackState state) {
        PlayerState playerState = PlayerState.STOPPED;

        if (state.isPlaying) playerState = PlayerState.PLAYING;
        if (state.isCompleted) playerState = PlayerState.COMPLETED;

        _listenPlayerStateChanged(playerState);
      });
    }
  }

  _listenPlayerStateChanged(PlayerState playerState) {
    assert(_debugAssertNotDisposed());
    if (_listeners != null) {
      final List<AudioPlayerListener> localListeners =
          List<AudioPlayerListener>.from(_listeners);
      for (final AudioPlayerListener listener in localListeners) {
        listener.onPlayerStateChanged(_lastPlayAudioUrl, playerState);
      }
    }
  }

  Future<void> play(String audioUrl) async {
    if (!_inited) _init();

    _lastPlayAudioUrl = audioUrl;

    if (kIsWeb) {
      await _audioPlayer.play(audioUrl);
      Future.delayed(Duration(seconds: 3)).then((_) {
        _listenPlayerStateChanged(PlayerState.COMPLETED);
      });
    } else {
      _vlcPlayer.stop();
      _vlcPlayer.open(
        vlc.Media.network(audioUrl),
        autoStart: false,
      );
      _vlcPlayer.play();
    }
  }

  Future<void> pause() async {
    if (!_inited) _init();

    if (kIsWeb) {
      await _audioPlayer.pause();
    } else {
      _vlcPlayer.pause();
    }
  }

  Future<void> stop() async {
    if (!_inited) _init();
    if (kIsWeb) {
      await _audioPlayer.stop();
    } else {
      _vlcPlayer.stop();
    }
  }
}
