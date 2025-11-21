@Deprecated('No longer used.')
const kPreferenceTypeInt = 'int';
@Deprecated('No longer used.')
const kPreferenceTypeBool = 'bool';

// 翻译
@Deprecated('No longer used.')
const kPrefTranslationMode = 'translation_mode';
@Deprecated('No longer used.')
const kPrefDefaultEngineId = 'default_engine_id';
@Deprecated('No longer used.')
const kPrefDefaultTranslateEngineId = 'default_translate_engine_id';
@Deprecated('No longer used.')
const kPrefDoubleClickCopyResult = 'double_click_copy_result';
// 取词
@Deprecated('No longer used.')
const kPrefDefaultOcrEngineId = 'default_ocr_engine_id';
@Deprecated('No longer used.')
const kPrefAutoCopyDetectedText = 'auto_copy_detected_text';
// 界面
@Deprecated('No longer used.')
const kPrefShowTrayIcon = 'show_tray_icon';
@Deprecated('No longer used.')
const kPrefMaxWindowHeight = 'max_window_height';
// 显示语言
@Deprecated('No longer used.')
const kPrefAppLanguage = 'app_language';
// 主题模式
@Deprecated('No longer used.')
const kPrefThemeMode = 'theme_mode';
// 快捷键
@Deprecated('No longer used.')
const kPrefShortcutShowOrHide = 'shortcut_show_or_hide';
@Deprecated('No longer used.')
const kPrefShortcutExtractFromScreenCapture =
    'shortcut_extract_text_from_screen_capture';
@Deprecated('No longer used.')
const kPrefShortcutExtractFromScreenSelection =
    'shortcut_extract_text_from_screen_selection';
@Deprecated('No longer used.')
const kPrefShortcutTranslateInputContent = 'shortcut_translate_input_content';
// 输入设置
@Deprecated('No longer used.')
const kPrefInputSetting = 'input_setting';

@Deprecated('No longer used.')
const kTranslationModeAuto = 'auto';
@Deprecated('No longer used.')
const kTranslationModeManual = 'manual';

@Deprecated('No longer used.')
const kInputSettingSubmitWithEnter = 'submit-with-enter';
@Deprecated('No longer used.')
const kInputSettingSubmitWithMetaEnter = 'submit-with-meta+enter';

@Deprecated('No longer used.')
const kShortcutShowOrHide = 'shortcut_show_or_hide';
@Deprecated('No longer used.')
const kShortcutHide = 'shortcut_hide';
@Deprecated('No longer used.')
const kShortcutExtractFromScreenSelection =
    'shortcut_extract_from_screen_selection';
@Deprecated('No longer used.')
const kShortcutExtractFromScreenCapture =
    'shortcut_extract_from_screen_capture';
@Deprecated('No longer used.')
const kShortcutExtractFromClipboard = 'shortcut_extract_from_clipboard';
@Deprecated('No longer used.')
const kShortcutTranslateInputContent = 'shortcut_translate_input_content';

@Deprecated('No longer used.')
class UserPreference {
  UserPreference({
    this.key,
    this.type,
    this.value,
  });

  factory UserPreference.fromJson(Map<dynamic, dynamic> json) {
    return UserPreference(
      key: json['key'],
      type: json['type'],
      value: json['value'],
    );
  }

  String? key;
  String? type;
  String? value;

  int? get intValue {
    if (type != kPreferenceTypeInt) return null;
    return int.parse(value!);
  }

  bool? get boolValue {
    if (type != kPreferenceTypeBool) return null;
    return value == 'true';
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'type': type,
      'value': value,
    };
  }
}
