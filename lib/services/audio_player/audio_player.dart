import 'dart:io';

import 'package:flutter/foundation.dart';

import 'audio_player_impl_aps.dart';
import 'audio_player_impl_lwm.dart';
import 'audio_player_listener.dart';

export 'audio_player_listener.dart';

enum AudioPlayerState {
  initialized,
  buffering,
  playing,
  paused,
  completed,
}

class AudioPlayer {
  static Future<void> ensureInitialized() {
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
      AudioPlayerImplLWM.initialize();
    }
    return Future.value();
  }

  static AudioPlayer create(int id) {
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
      return AudioPlayerImplLWM(id);
    } else {
      return AudioPlayerImplAPS(id);
    }
  }

  static AudioPlayer? _instance;

  static AudioPlayer get instance {
    _instance ??= AudioPlayer.create(1);
    return _instance!;
  }

  final ObserverList<AudioPlayerListener> _listeners =
      ObserverList<AudioPlayerListener>();

  List<AudioPlayerListener> get listeners {
    final List<AudioPlayerListener> localListeners =
        List<AudioPlayerListener>.from(_listeners);
    return localListeners;
  }

  bool get hasListeners {
    return _listeners.isNotEmpty;
  }

  void addListener(AudioPlayerListener listener) {
    _listeners.add(listener);
  }

  void removeListener(AudioPlayerListener listener) {
    _listeners.remove(listener);
  }

  Uri getSource() {
    throw UnimplementedError();
  }

  Future<void> setSource(Uri url) {
    throw UnimplementedError();
  }

  /// Prepares the player for playback.
  Future<void> prepare() {
    throw UnimplementedError();
  }

  /// Starts or resumes playback.
  Future<void> start() {
    throw UnimplementedError();
  }

  /// Stops playback after playback has been started or paused.
  Future<void> stop() {
    throw UnimplementedError();
  }

  /// Pauses playback.
  Future<void> pause() {
    throw UnimplementedError();
  }

  /// Seeks to specified time position.
  Future<void> seekTo(Duration duration) {
    throw UnimplementedError();
  }

  /// Releases resources associated with this AudioPlayer object.
  Future<void> release() {
    throw UnimplementedError();
  }

  /// Gets the current playback position.
  Duration getCurrentPosition() {
    throw UnimplementedError();
  }

  /// Gets the duration of the file.
  Duration getDuration() {
    throw UnimplementedError();
  }
}
