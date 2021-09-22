import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../includes.dart';

const _kIconSize = 18.0;

class SoundPlayButton extends StatefulWidget {
  final String audioUrl;

  const SoundPlayButton({
    this.audioUrl,
  });

  @override
  _SoundPlayButtonState createState() => _SoundPlayButtonState();
}

class _SoundPlayButtonState extends State<SoundPlayButton>
    with AudioPlayerListener {
  bool _playing = false;
  int _playingAnimImageIndex = 0;
  Timer _playingAnimTimer;

  @override
  void initState() {
    AudioPlayer.instance.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    AudioPlayer.instance.removeListener(this);
    _stopPlayingAnimTimer();
    super.dispose();
  }

  void _startPlayingAnimTimer() {
    _stopPlayingAnimTimer();
    _playingAnimTimer = Timer.periodic(
      new Duration(milliseconds: 300),
      (Timer timer) {
        setState(() {
          _playingAnimImageIndex =
              _playingAnimImageIndex + 1 > 2 ? 0 : _playingAnimImageIndex + 1;
        });
      },
    );
    if (mounted) {
      setState(() {
        _playingAnimImageIndex = 2;
      });
    }
  }

  void _stopPlayingAnimTimer() {
    if (_playingAnimTimer != null && _playingAnimTimer.isActive) {
      _playingAnimTimer.cancel();
    }
    _playingAnimTimer = null;
    if (mounted) {
      setState(() {
        _playingAnimImageIndex = 0;
      });
    }
  }

  void _handleClickPlay() {
    AudioPlayer.instance.setSource(Uri.parse(widget.audioUrl));
    AudioPlayer.instance.prepare();
    AudioPlayer.instance.start();
    _startPlayingAnimTimer();
  }

  void _handleClickStop() {
    AudioPlayer.instance.stop();
    _stopPlayingAnimTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Center(
          child: IndexedStack(
            index: _playingAnimImageIndex,
            alignment: Alignment.center,
            children: <Widget>[
              SizedBox(
                width: _kIconSize,
                height: _kIconSize,
                child: Icon(
                  IcoMoonIcons.volume_up,
                  size: _kIconSize,
                  color: Theme.of(context).textTheme.caption.color,
                ),
              ),
              SizedBox(
                width: _kIconSize,
                height: _kIconSize,
                child: Icon(
                  IcoMoonIcons.volume_down,
                  size: _kIconSize,
                  color: Theme.of(context).textTheme.caption.color,
                ),
              ),
              SizedBox(
                width: _kIconSize,
                height: _kIconSize,
                child: Icon(
                  IcoMoonIcons.volume_off,
                  size: _kIconSize,
                  color: Theme.of(context).textTheme.caption.color,
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
          if (!_playing) {
            _handleClickPlay();
          } else {
            _handleClickStop();
          }
        },
      ),
    );
  }

  @override
  void onAudioPlayerBufferingUpdate(AudioPlayer ap, bool isBuffered) {}

  @override
  void onAudioPlayerStateChanged(AudioPlayer ap, AudioPlayerState state) {
    if (ap.getSource().toString() == widget.audioUrl) {
      _playing = state == AudioPlayerState.playing;
    } else {
      _playing = false;
    }
    if (_playing && !(_playingAnimTimer?.isActive ?? false)) {
      _startPlayingAnimTimer();
    } else if (!_playing && (_playingAnimTimer?.isActive ?? false)) {
      _stopPlayingAnimTimer();
    }
    if (mounted) setState(() {});
  }

  @override
  void onAudioPlayerPositionChanged(AudioPlayer ap) {}

  @override
  void onAudioPlayerCompleted(AudioPlayer ap) {}
}
