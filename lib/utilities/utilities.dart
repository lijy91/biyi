import 'dart:io';

import 'package:biyi/includes.dart';
import 'package:flutter/foundation.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

// 请按文件名排序放置
export './env.dart';
export './global_key_ex.dart';
export './language_util.dart';
export './platform_util.dart';
export './pretty_json.dart';
export './r.dart';
export './remove_nulls.dart';

final sharedEnv = Env.instance;

final ScreenRetriever screenRetriever = ScreenRetriever.instance;

Directory? _dataDirectory;

Future<Directory> getAppDirectory() async {
  if (!kIsWeb && _dataDirectory == null) {
    final docDir = await getApplicationDocumentsDirectory();

    if (kIsLinux || kIsWindows) {
      _dataDirectory = Directory(path.join(docDir.parent.path, '.biyi'));
      if (!_dataDirectory!.existsSync()) {
        _dataDirectory!.createSync(recursive: true);
      }
    } else {
      _dataDirectory = docDir;
    }
  }
  return _dataDirectory!;
}

Future<Directory> getUserDataDirectory() async {
  final appDirectory = await getAppDirectory();

  final userDataDirectory = Directory(path.join(
    appDirectory.path,
    'local',
  ));

  Directory userWordbooksDir = Directory(
    path.join(userDataDirectory.path, 'wordbooks'),
  );
  if (!userWordbooksDir.existsSync()) {
    userWordbooksDir.createSync(recursive: true);
  }

  return userDataDirectory;
}
