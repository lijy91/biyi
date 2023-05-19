import '../../includes.dart';

abstract mixin class LocalDbListener {
  void onUserChanged(User oldUser, User newUser) {}
}
