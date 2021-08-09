import 'dart:io';

class DartVLC {
  static void initialize() {}
}

class Player {
  Player({int id});
  Stream<PlaybackState> playbackStream;

  void open(MediaSource source, {bool autoStart: true}) {}
  void play() {}
  void pause() {}
  void playOrPause() {}
  void stop() {}
}

class PlaybackState {
  bool isPlaying = false;
  bool isSeekable = true;
  bool isCompleted = false;
}

abstract class MediaSource {
  dynamic mediaSourceType;
}

class Media extends MediaSource {
  static Media file(
    File file, {
    bool parse: false,
    Map<String, dynamic> extras,
    Duration timeout: const Duration(seconds: 10),
  }) {
    return null;
  }

  static Media network(
    dynamic url, {
    bool parse: false,
    Map<String, dynamic> extras,
    Duration timeout: const Duration(seconds: 10),
  }) {
    return null;
  }

  static Media directShow({
    String vdev = '',
    String adev = '',
    int liveCaching,
  }) {
    return null;
  }

  static Media asset(String asset) {
    return null;
  }

  void parse(Duration timeout) {}
}
