import 'package:biyi_api_client/biyi_api_client.dart';
import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/models/translation_target.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uikit/uikit.dart' show ThemeMode;
import 'package:uni_platform/uni_platform.dart';

part 'settings_base.g.dart';

enum TranslationMode {
  auto,
  manual;

  static TranslationMode fromString(String value) {
    switch (value) {
      case 'auto':
        return TranslationMode.auto;
      case 'manual':
        return TranslationMode.manual;
      default:
        return TranslationMode.auto;
    }
  }

  String get displayName {
    switch (this) {
      case TranslationMode.auto:
        return t.translation_mode.auto;
      case TranslationMode.manual:
        return t.translation_mode.manual;
    }
  }
}

enum InputSubmitMode {
  enter,
  metaEnter,
}

@JsonSerializable()
class BoundShortcuts {
  BoundShortcuts({
    HotKey? showOrHide,
    HotKey? hide,
    HotKey? extractFromScreenSelection,
    HotKey? extractFromScreenCapture,
    HotKey? extractFromClipboard,
    HotKey? translateInputContent,
  })  : _showOrHide = showOrHide,
        _hide = hide,
        _extractFromScreenSelection = extractFromScreenSelection,
        _extractFromScreenCapture = extractFromScreenCapture,
        _extractFromClipboard = extractFromClipboard,
        _translateInputContent = translateInputContent;

  factory BoundShortcuts.fromJson(Map<String, dynamic> json) =>
      _$BoundShortcutsFromJson(json);

  HotKey? _showOrHide;
  HotKey? _hide;

  HotKey? _extractFromScreenSelection;
  HotKey? _extractFromScreenCapture;
  HotKey? _extractFromClipboard;

  HotKey? _translateInputContent;

  HotKey get showOrHide {
    return _showOrHide ??
        HotKey(
          key: PhysicalKeyboardKey.digit1,
          modifiers: [HotKeyModifier.alt],
          identifier: 'showOrHide',
        );
  }

  set showOrHide(value) {
    _showOrHide = value;
  }

  HotKey get hide {
    return _hide ??
        HotKey(
          identifier: 'hide',
          key: PhysicalKeyboardKey.escape,
          modifiers: [],
          scope: HotKeyScope.inapp,
        );
  }

  set hide(value) => _hide = value;

  HotKey get extractFromScreenSelection {
    return _extractFromScreenSelection ??
        HotKey(
          identifier: 'extract-from-screen-selection',
          key: PhysicalKeyboardKey.keyQ,
          modifiers: [HotKeyModifier.alt],
        );
  }

  set extractFromScreenSelection(value) => _extractFromScreenSelection = value;

  HotKey get extractFromScreenCapture {
    return _extractFromScreenCapture ??
        HotKey(
          identifier: 'extract-from-screen-capture',
          key: PhysicalKeyboardKey.keyW,
          modifiers: [HotKeyModifier.alt],
        );
  }

  set extractFromScreenCapture(value) => _extractFromScreenCapture = value;

  HotKey get extractFromClipboard {
    return _extractFromClipboard ??
        HotKey(
          identifier: 'extract-from-clipboard',
          key: PhysicalKeyboardKey.keyE,
          modifiers: [HotKeyModifier.alt],
        );
  }

  set extractFromClipboard(value) => _extractFromClipboard = value;

  HotKey get translateInputContent {
    return _translateInputContent ??
        HotKey(
          identifier: 'translate-input-content',
          key: PhysicalKeyboardKey.keyZ,
          modifiers: [HotKeyModifier.alt],
        );
  }

  set translateInputContent(value) => _translateInputContent = value;

  HotKey get inputSubmitWithMetaEnter {
    if (UniPlatform.isMacOS) {
      return HotKey(
        key: PhysicalKeyboardKey.enter,
        modifiers: [HotKeyModifier.meta],
        scope: HotKeyScope.inapp,
      );
    }
    return HotKey(
      key: PhysicalKeyboardKey.enter,
      modifiers: [HotKeyModifier.control],
      scope: HotKeyScope.inapp,
    );
  }

  Map<String, dynamic> toJson() => _$BoundShortcutsToJson(this);
}

@JsonSerializable()
class SettingsBase {
  SettingsBase({
    this.defaultOcrEngineId,
    this.autoCopyRecognizedText = true,
    this.defaultTranslationEngineId,
    this.translationMode = TranslationMode.manual,
    this.defaultDetectLanguageEngineId,
    List<TranslationTarget>? translationTargets,
    this.doubleClickCopyResult = true,
    this.inputSubmitMode = InputSubmitMode.enter,
    this.themeMode = ThemeMode.light,
    this.trayIconEnabled = true,
    this.maxWindowHeight = 800,
    BoundShortcuts? boundShortcuts,
    this.displayLanguage,
    this.autoStartEnabled = false,
    List<OcrEngineConfig>? ocrEngines,
    List<TranslationEngineConfig>? translationEngines,
  })  : translationTargets = translationTargets ?? [],
        boundShortcuts = boundShortcuts ?? BoundShortcuts(),
        ocrEngines = ocrEngines ?? [],
        translationEngines = translationEngines ?? [];

  factory SettingsBase.fromJson(Map<String, dynamic> json) =>
      _$SettingsBaseFromJson(json);

  // #region 通用

  /// 默认文字识别引擎
  String? defaultOcrEngineId;

  OcrEngineConfig? get defaultOcrEngineConfig {
    return ocrEngines.firstWhereOrNull(
      (engine) => engine.id == defaultOcrEngineId,
    );
  }

  /// 自动复制检测到的文本
  bool autoCopyRecognizedText;

  /// 默认文本翻译引擎
  String? defaultTranslationEngineId;

  TranslationEngineConfig? get defaultTranslationEngineConfig {
    return translationEngines.firstWhereOrNull(
      (engine) => engine.id == defaultTranslationEngineId,
    );
  }

  /// 翻译模式
  TranslationMode translationMode;

  /// 默认语种识别引擎
  String? defaultDetectLanguageEngineId;

  TranslationEngineConfig? get defaultDetectLanguageEngineConfig {
    return translationEngines.firstWhereOrNull(
      (engine) => engine.id == defaultDetectLanguageEngineId,
    );
  }

  List<TranslationTarget> translationTargets;

  /// 双击复制结果
  bool doubleClickCopyResult;

  /// 输入提交模式
  InputSubmitMode inputSubmitMode;

  // #endregion

  // #region 外观

  /// 主题模式
  ThemeMode themeMode;

  /// 是否启用托盘图标
  bool trayIconEnabled;

  /// 最大窗口高度
  double maxWindowHeight = 800;

  // #endregion

  // #region 快捷键

  BoundShortcuts boundShortcuts;

  // #endregion

  // #region 语言

  /// 显示语言

  String? displayLanguage;

  // #endregion

  // #region 高级

  bool autoStartEnabled;

  // #endregion

  // #region 文字识别

  List<OcrEngineConfig> ocrEngines;

  // #endregion

  // #region 文本翻译

  List<TranslationEngineConfig> translationEngines;

  // #endregion

  Map<String, dynamic> toJson() => _$SettingsBaseToJson(this);
}
