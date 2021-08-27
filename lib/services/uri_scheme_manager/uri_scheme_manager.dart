import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uni_links/uni_links.dart';

import '../../includes.dart';

abstract class UriSchemeListener {
  void onUriSchemeLaunch(Uri uri);
}

class UriSchemeManager {
  UriSchemeManager._();

  /// The shared instance of [UriSchemeManager].
  static final UriSchemeManager instance = UriSchemeManager._();

  final ObserverList<UriSchemeListener> _listeners =
      ObserverList<UriSchemeListener>();

  bool _inited = false;
  StreamSubscription _sub;

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

  void addListener(UriSchemeListener listener) {
    assert(_debugAssertNotDisposed());
    if (!_inited) _init();
    _listeners.add(listener);
  }

  void removeListener(UriSchemeListener listener) {
    assert(_debugAssertNotDisposed());
    _listeners.remove(listener);
    if (_listeners.isEmpty) {
      if (_sub == null) {
        _sub?.cancel();
      }
    }
  }

  void _init() async {
    if (_inited) return;
    if (kIsWeb || kIsLinux || kIsWindows) return;
    _sub = uriLinkStream.listen(
      (Uri uri) {
        _listenUriSchemeLaunch(uri);
      },
    );
    _inited = true;
  }

  _listenUriSchemeLaunch(Uri uri) {
    assert(_debugAssertNotDisposed());
    if (_listeners != null) {
      final List<UriSchemeListener> localListeners =
          List<UriSchemeListener>.from(_listeners);
      for (final UriSchemeListener listener in localListeners) {
        listener.onUriSchemeLaunch(uri);
      }
    }
  }
}
