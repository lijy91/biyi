import "dart:io";

import 'package:archive/archive_io.dart';
import 'package:yaml/yaml.dart';

const kLinux = 'linux';
const kMacOS = 'macos';
const kWindows = 'windows';

final Directory workDir = Directory.current;
final Directory distDir = Directory('${workDir.path}/dist');
final Directory buildDir = Directory('${workDir.path}/build');

class ReleaseInfo {
  final String platform;
  final String name;
  final String description;
  final String buildNumber;
  final String version;

  ReleaseInfo({
    this.platform,
    this.name,
    this.description,
    this.buildNumber,
    this.version,
  });

  factory ReleaseInfo.fromPlatform(String platform) {
    final yamlString = File('${workDir.path}/pubspec.yaml').readAsStringSync();
    final yamlDoc = loadYaml(yamlString);

    String pubspecName = yamlDoc['name'];
    String pubspecVersion = yamlDoc['version'];

    return ReleaseInfo(
      platform: platform,
      name: pubspecName.split('_').first,
      buildNumber: pubspecVersion.split('+').last,
      version: pubspecVersion.split('+').first,
    );
  }

  String get buildSubcommand {
    switch (platform) {
      case kMacOS:
        return 'macos';
      case kWindows:
        return 'windows';
      default:
    }
    return null;
  }

  Directory get buildOutputDir {
    switch (platform) {
      case kMacOS:
        return Directory('${workDir.path}/build/macos/Build/Products/Release');
      case kWindows:
        return Directory('${workDir.path}/build/windows/runner/Release');
      default:
    }
    return null;
  }

  Directory get binaryArchiveDir {
    return Directory('${distDir.path}/$version/$name-$platform-v$version');
  }

  File get binaryFile {
    String fileExt = '';
    switch (platform) {
      case kMacOS:
        fileExt = 'dmg';
        break;
      case kWindows:
        fileExt = 'zip';
        break;
      default:
    }
    return File('${distDir.path}/$version/$name-$platform-v$version.$fileExt');
  }
}

void main(List<String> args) async {
  final String platform = args[0];

  final ReleaseInfo releaseInfo = ReleaseInfo.fromPlatform(platform);

  await Process.run('flutter', ['clean'], runInShell: true);
  Process progress = await Process.start(
    'flutter',
    ['build', releaseInfo.buildSubcommand],
    runInShell: true,
  )
    ..stdout.listen((event) => print(String.fromCharCodes(event).trim()))
    ..stderr.listen((event) => print(String.fromCharCodes(event).trim()));

  int exitCode = await progress.exitCode;
  if (exitCode != 0) {
    print('exitCode: $exitCode');
    return;
  }

  File binaryFile = releaseInfo.binaryFile;
  if (releaseInfo.binaryArchiveDir.existsSync()) {
    releaseInfo.binaryArchiveDir.deleteSync(recursive: true);
  }
  releaseInfo.binaryArchiveDir.createSync(recursive: true);

  String buildOutputPath = releaseInfo.buildOutputDir.path;
  String binaryArchivePath = releaseInfo.binaryArchiveDir.path;

  if (platform == kMacOS) {
    String dmgFilename =
        '${releaseInfo.name} ${releaseInfo.version.split('-').first}.dmg';
    await Process.run(
      'create-dmg',
      [
        '$buildOutputPath/${releaseInfo.name}.app',
        binaryFile.parent.path,
      ],
      runInShell: true,
    );
    await Process.run(
      'mv',
      ['${binaryFile.parent.path}/$dmgFilename', binaryFile.path],
    );
  } else if (platform == kWindows) {
    await Process.run('cp', ['-R', buildOutputPath, binaryArchivePath]);
    await Process.run('mv', [buildOutputPath, binaryArchivePath]);
    await Process.run('mv', [
      '$binaryArchivePath/Release',
      '$binaryArchivePath/${releaseInfo.name}'
    ]);

    final zipFileEncoder = ZipFileEncoder();
    zipFileEncoder.zipDirectory(
      releaseInfo.binaryArchiveDir,
      filename: binaryFile.path,
    );
  }

  releaseInfo.binaryArchiveDir.deleteSync(recursive: true);
}
