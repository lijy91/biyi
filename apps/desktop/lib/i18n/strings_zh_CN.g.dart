///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsZhCn implements Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsZhCn(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = TranslationMetadata(
          locale: AppLocale.zhCn,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <zh-CN>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final TranslationsZhCn _root = this; // ignore: unused_field

  // Translations
  @override
  String get app_name => '比译';
  @override
  String get ok => '确定';
  @override
  String get cancel => '取消';
  @override
  String get add => '添加';
  @override
  String get delete => '删除';
  @override
  String get copied => '已复制';
  @override
  String get please_choose => '请选择';
  @override
  late final _TranslationsLanguageZhCn language =
      _TranslationsLanguageZhCn._(_root);
  @override
  late final _TranslationsEngineZhCn engine = _TranslationsEngineZhCn._(_root);
  @override
  late final _TranslationsEngineScopeZhCn engine_scope =
      _TranslationsEngineScopeZhCn._(_root);
  @override
  late final _TranslationsOcrEngineZhCn ocr_engine =
      _TranslationsOcrEngineZhCn._(_root);
  @override
  late final _TranslationsTranslationModeZhCn translation_mode =
      _TranslationsTranslationModeZhCn._(_root);
  @override
  late final _TranslationsThemeModeZhCn theme_mode =
      _TranslationsThemeModeZhCn._(_root);
  @override
  late final _TranslationsWordPronunciationZhCn word_pronunciation =
      _TranslationsWordPronunciationZhCn._(_root);
  @override
  late final _TranslationsTrayContextMenuZhCn tray_context_menu =
      _TranslationsTrayContextMenuZhCn._(_root);
  @override
  late final _TranslationsAppZhCn app = _TranslationsAppZhCn._(_root);
  @override
  late final _TranslationsWidgetZhCn widget = _TranslationsWidgetZhCn._(_root);
}

// Path: language
class _TranslationsLanguageZhCn implements TranslationsLanguageEn {
  _TranslationsLanguageZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get af => '布尔语(南非荷兰语)';
  @override
  String get am => '阿姆哈拉语';
  @override
  String get ar => '阿拉伯语';
  @override
  String get az => '阿塞拜疆语';
  @override
  String get be => '白俄罗斯语';
  @override
  String get bg => '保加利亚语';
  @override
  String get bn => '孟加拉语';
  @override
  String get bs => '波斯尼亚语';
  @override
  String get ca => '加泰罗尼亚语';
  @override
  String get ceb => '宿务语';
  @override
  String get co => '科西嘉语';
  @override
  String get cs => '捷克语';
  @override
  String get cy => '威尔士语';
  @override
  String get da => '丹麦语';
  @override
  String get de => '德语';
  @override
  String get el => '希腊语';
  @override
  String get en => '英语';
  @override
  String get eo => '世界语';
  @override
  String get es => '西班牙语';
  @override
  String get et => '爱沙尼亚语';
  @override
  String get eu => '巴斯克语';
  @override
  String get fa => '波斯语';
  @override
  String get fi => '芬兰语';
  @override
  String get fr => '法语';
  @override
  String get fy => '弗里西语';
  @override
  String get ga => '爱尔兰语';
  @override
  String get gd => '苏格兰盖尔语';
  @override
  String get gl => '加利西亚语';
  @override
  String get gu => '古吉拉特语';
  @override
  String get ha => '豪萨语';
  @override
  String get haw => '夏威夷语';
  @override
  String get he => '希伯来语';
  @override
  String get hi => '印地语';
  @override
  String get hmn => '苗语';
  @override
  String get hr => '克罗地亚语';
  @override
  String get ht => '海地克里奥尔语';
  @override
  String get hu => '匈牙利语';
  @override
  String get hy => '亚美尼亚语';
  @override
  String get id => '印尼语';
  @override
  String get ig => '伊博语';
  @override
  String get kIs => '冰岛语';
  @override
  String get it => '意大利语';
  @override
  String get iw => '希伯来语';
  @override
  String get ja => '日语';
  @override
  String get jw => '印尼爪哇语';
  @override
  String get ka => '格鲁吉亚语';
  @override
  String get kk => '哈萨克语';
  @override
  String get km => '高棉语';
  @override
  String get kn => '卡纳达语';
  @override
  String get ko => '韩语';
  @override
  String get ku => '库尔德语';
  @override
  String get ky => '吉尔吉斯语';
  @override
  String get la => '拉丁语';
  @override
  String get lb => '卢森堡语';
  @override
  String get lo => '老挝语';
  @override
  String get lt => '立陶宛语';
  @override
  String get lv => '拉脱维亚语';
  @override
  String get mg => '马尔加什语';
  @override
  String get mi => '毛利语';
  @override
  String get mk => '马其顿语';
  @override
  String get ml => '马拉雅拉姆语';
  @override
  String get mn => '蒙古语';
  @override
  String get mr => '马拉地语';
  @override
  String get ms => '马来语';
  @override
  String get mt => '马耳他语';
  @override
  String get my => '缅甸语';
  @override
  String get ne => '尼泊尔语';
  @override
  String get nl => '荷兰语';
  @override
  String get no => '挪威语';
  @override
  String get ny => '齐切瓦语';
  @override
  String get or => '奥利亚语';
  @override
  String get pa => '旁遮普语';
  @override
  String get pl => '波兰语';
  @override
  String get ps => '普什图语';
  @override
  String get pt => '葡萄牙语';
  @override
  String get ro => '罗马尼亚语';
  @override
  String get ru => '俄语';
  @override
  String get rw => '卢旺达语';
  @override
  String get sd => '信德语';
  @override
  String get si => '僧伽罗语';
  @override
  String get sk => '斯洛伐克语';
  @override
  String get sl => '斯洛文尼亚语';
  @override
  String get sm => '萨摩亚语';
  @override
  String get sn => '修纳语';
  @override
  String get so => '索马里语';
  @override
  String get sq => '阿尔巴尼亚语';
  @override
  String get sr => '塞尔维亚语';
  @override
  String get st => '塞索托语';
  @override
  String get su => '印尼巽他语';
  @override
  String get sv => '瑞典语';
  @override
  String get sw => '斯瓦希里语';
  @override
  String get ta => '泰米尔语';
  @override
  String get te => '泰卢固语';
  @override
  String get tg => '塔吉克语';
  @override
  String get th => '泰语';
  @override
  String get tk => '土库曼语';
  @override
  String get tl => '菲律宾语';
  @override
  String get tr => '土耳其语';
  @override
  String get tt => '鞑靼语';
  @override
  String get ug => '维吾尔语';
  @override
  String get uk => '乌克兰语';
  @override
  String get ur => '乌尔都语';
  @override
  String get uz => '乌兹别克语';
  @override
  String get vi => '越南语';
  @override
  String get xh => '南非科萨语';
  @override
  String get yi => '意第绪语';
  @override
  String get yo => '约鲁巴语';
  @override
  String get zh => '中文';
  @override
  String get zh_CN => '中文';
  @override
  String get zh_TW => '中文(繁体)';
  @override
  String get zu => '南非祖鲁语';
}

// Path: engine
class _TranslationsEngineZhCn implements TranslationsEngineEn {
  _TranslationsEngineZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get baidu => '百度翻译';
  @override
  String get caiyun => '彩云小译';
  @override
  String get deepl => 'DeepL';
  @override
  String get google => '谷歌翻译';
  @override
  String get ibmwatson => 'IBMWatson';
  @override
  String get iciba => '爱词霸';
  @override
  String get openai => 'OpenAI';
  @override
  String get sogou => '搜狗翻译';
  @override
  String get tencent => '腾讯翻译君';
  @override
  String get youdao => '有道翻译';
}

// Path: engine_scope
class _TranslationsEngineScopeZhCn implements TranslationsEngineScopeEn {
  _TranslationsEngineScopeZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get detectlanguage => '语种识别';
  @override
  String get lookup => '查词';
  @override
  String get translate => '翻译';
}

// Path: ocr_engine
class _TranslationsOcrEngineZhCn implements TranslationsOcrEngineEn {
  _TranslationsOcrEngineZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get built_in => '内置';
  @override
  String get tesseract => 'Tesseract OCR';
  @override
  String get youdao => '有道通用文字识别';
}

// Path: translation_mode
class _TranslationsTranslationModeZhCn
    implements TranslationsTranslationModeEn {
  _TranslationsTranslationModeZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get auto => '自动';
  @override
  String get manual => '手动';
}

// Path: theme_mode
class _TranslationsThemeModeZhCn implements TranslationsThemeModeEn {
  _TranslationsThemeModeZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get light => '浅色';
  @override
  String get dark => '深色';
  @override
  String get system => '跟随系统';
}

// Path: word_pronunciation
class _TranslationsWordPronunciationZhCn
    implements TranslationsWordPronunciationEn {
  _TranslationsWordPronunciationZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get us => '美';
  @override
  String get uk => '英';
}

// Path: tray_context_menu
class _TranslationsTrayContextMenuZhCn
    implements TranslationsTrayContextMenuEn {
  _TranslationsTrayContextMenuZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get item_show => '显示';
  @override
  String get item_quick_start_guide => '快速入门';
  @override
  String get item_discussion => '加入讨论';
  @override
  String get item_quit_app => '退出比译';
  @override
  String get item_discussion_subitem_discord_server => '加入 Discord';
  @override
  String get item_discussion_subitem_qq_group => '加入 QQ 群';
}

// Path: app
class _TranslationsAppZhCn implements TranslationsAppEn {
  _TranslationsAppZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsAppHomeZhCn home = _TranslationsAppHomeZhCn._(_root);
  @override
  late final _TranslationsAppRecordShortcutZhCn record_shortcut =
      _TranslationsAppRecordShortcutZhCn._(_root);
  @override
  late final _TranslationsAppOcrEngineTypesZhCn ocr_engine_types =
      _TranslationsAppOcrEngineTypesZhCn._(_root);
  @override
  late final _TranslationsAppOcrEnginesZhCn ocr_engines =
      _TranslationsAppOcrEnginesZhCn._(_root);
  @override
  late final _TranslationsAppOcrEnginesNewZhCn ocr_engines_new =
      _TranslationsAppOcrEnginesNewZhCn._(_root);
  @override
  late final _TranslationsAppSettingsZhCn settings =
      _TranslationsAppSettingsZhCn._(_root);
  @override
  late final _TranslationsAppSupportedLanguagesZhCn supported_languages =
      _TranslationsAppSupportedLanguagesZhCn._(_root);
  @override
  late final _TranslationsAppTranslationEngineTypesZhCn
      translation_engine_types =
      _TranslationsAppTranslationEngineTypesZhCn._(_root);
  @override
  late final _TranslationsAppTranslationEnginesZhCn translation_engines =
      _TranslationsAppTranslationEnginesZhCn._(_root);
  @override
  late final _TranslationsAppTranslationEnginesNewZhCn translation_engines_new =
      _TranslationsAppTranslationEnginesNewZhCn._(_root);
  @override
  late final _TranslationsAppTranslationTargetsZhCn translation_targets =
      _TranslationsAppTranslationTargetsZhCn._(_root);
}

// Path: widget
class _TranslationsWidgetZhCn implements TranslationsWidgetEn {
  _TranslationsWidgetZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsWidgetRecordShortcutDialogZhCn
      record_shortcut_dialog =
      _TranslationsWidgetRecordShortcutDialogZhCn._(_root);
}

// Path: app.home
class _TranslationsAppHomeZhCn implements TranslationsAppHomeEn {
  _TranslationsAppHomeZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String newversion_banner_text_found_new_version({required Object version}) =>
      '发现新版本：${version}';
  @override
  String get newversion_banner_btn_update => '立即更新';
  @override
  String get limited_banner_title => '功能受限，请根据提示进行检查。';
  @override
  String get limited_banner_text_screen_capture => '授予屏幕录制权限';
  @override
  String get limited_banner_text_screen_selection => '授予辅助功能权限';
  @override
  String get limited_banner_btn_allow => '允许';
  @override
  String get limited_banner_btn_go_settings => '前往设置';
  @override
  String get limited_banner_btn_check_again => '重新检查';
  @override
  String get limited_banner_tip_help => '查看帮助文档';
  @override
  String get limited_banner_msg_allow_access_tip =>
      '点击「授权」后如无任何响应，请点击「前往设置」进行手动设置。';
  @override
  String get limited_banner_msg_all_access_allowed => '屏幕取词功能已启用';
  @override
  String get limited_banner_msg_all_access_not_allowed =>
      '未获得所需权限，\n请重新检查并进行设置。';
  @override
  String get input_hint => '在此处输入单词或文本';
  @override
  String get text_extracting_text => '正在提取文字...';
  @override
  String tip_translation_mode({required Object mode}) => '当前翻译模式：${mode}';
  @override
  String get tip_extract_text_from_screen_capture => '截取屏幕区域并识别文字';
  @override
  String get tip_extract_text_from_clipboard => '读取剪切板内容';
  @override
  String get btn_clear => '清空';
  @override
  String get btn_trans => '翻译';
  @override
  String get msg_please_enter_word_or_text => '未输入或未提取到文本';
  @override
  String get msg_capture_screen_area_canceled => '截取屏幕区域已取消';
}

// Path: app.record_shortcut
class _TranslationsAppRecordShortcutZhCn
    implements TranslationsAppRecordShortcutEn {
  _TranslationsAppRecordShortcutZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '录制你的快捷键';
}

// Path: app.ocr_engine_types
class _TranslationsAppOcrEngineTypesZhCn
    implements TranslationsAppOcrEngineTypesEn {
  _TranslationsAppOcrEngineTypesZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '引擎类型';
}

// Path: app.ocr_engines
class _TranslationsAppOcrEnginesZhCn implements TranslationsAppOcrEnginesEn {
  _TranslationsAppOcrEnginesZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '文字识别引擎';
  @override
  late final _TranslationsAppOcrEnginesMsgZhCn msg =
      _TranslationsAppOcrEnginesMsgZhCn._(_root);
  @override
  late final _TranslationsAppOcrEnginesPrivateZhCn private =
      _TranslationsAppOcrEnginesPrivateZhCn._(_root);
}

// Path: app.ocr_engines_new
class _TranslationsAppOcrEnginesNewZhCn
    implements TranslationsAppOcrEnginesNewEn {
  _TranslationsAppOcrEnginesNewZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '添加文字识别引擎';
  @override
  late final _TranslationsAppOcrEnginesNewEngineTypeZhCn engine_type =
      _TranslationsAppOcrEnginesNewEngineTypeZhCn._(_root);
  @override
  late final _TranslationsAppOcrEnginesNewOptionZhCn option =
      _TranslationsAppOcrEnginesNewOptionZhCn._(_root);
}

// Path: app.settings
class _TranslationsAppSettingsZhCn implements TranslationsAppSettingsEn {
  _TranslationsAppSettingsZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Settings';
  @override
  String text_version({required Object version, required Object buildNumber}) =>
      'Version ${version} BUILD ${buildNumber}';
  @override
  late final _TranslationsAppSettingsKLayoutZhCn kLayout =
      _TranslationsAppSettingsKLayoutZhCn._(_root);
  @override
  late final _TranslationsAppSettingsAboutZhCn about =
      _TranslationsAppSettingsAboutZhCn._(_root);
  @override
  late final _TranslationsAppSettingsAdvancedZhCn advanced =
      _TranslationsAppSettingsAdvancedZhCn._(_root);
  @override
  late final _TranslationsAppSettingsAppearanceZhCn appearance =
      _TranslationsAppSettingsAppearanceZhCn._(_root);
  @override
  late final _TranslationsAppSettingsChangelogZhCn changelog =
      _TranslationsAppSettingsChangelogZhCn._(_root);
  @override
  late final _TranslationsAppSettingsGeneralZhCn general =
      _TranslationsAppSettingsGeneralZhCn._(_root);
  @override
  late final _TranslationsAppSettingsKeybindsZhCn keybinds =
      _TranslationsAppSettingsKeybindsZhCn._(_root);
  @override
  late final _TranslationsAppSettingsLanguageZhCn language =
      _TranslationsAppSettingsLanguageZhCn._(_root);
  @override
  late final _TranslationsAppSettingsOcrEnginesZhCn ocr_engines =
      _TranslationsAppSettingsOcrEnginesZhCn._(_root);
  @override
  late final _TranslationsAppSettingsTranslationEnginesZhCn
      translation_engines =
      _TranslationsAppSettingsTranslationEnginesZhCn._(_root);
}

// Path: app.supported_languages
class _TranslationsAppSupportedLanguagesZhCn
    implements TranslationsAppSupportedLanguagesEn {
  _TranslationsAppSupportedLanguagesZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '支持的语言';
  @override
  late final _TranslationsAppSupportedLanguagesAllZhCn all =
      _TranslationsAppSupportedLanguagesAllZhCn._(_root);
}

// Path: app.translation_engine_types
class _TranslationsAppTranslationEngineTypesZhCn
    implements TranslationsAppTranslationEngineTypesEn {
  _TranslationsAppTranslationEngineTypesZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '引擎类型';
}

// Path: app.translation_engines
class _TranslationsAppTranslationEnginesZhCn
    implements TranslationsAppTranslationEnginesEn {
  _TranslationsAppTranslationEnginesZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '文本翻译引擎';
  @override
  late final _TranslationsAppTranslationEnginesMsgZhCn msg =
      _TranslationsAppTranslationEnginesMsgZhCn._(_root);
  @override
  late final _TranslationsAppTranslationEnginesPrivateZhCn private =
      _TranslationsAppTranslationEnginesPrivateZhCn._(_root);
}

// Path: app.translation_engines_new
class _TranslationsAppTranslationEnginesNewZhCn
    implements TranslationsAppTranslationEnginesNewEn {
  _TranslationsAppTranslationEnginesNewZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '添加文本翻译引擎';
  @override
  late final _TranslationsAppTranslationEnginesNewEngineTypeZhCn engine_type =
      _TranslationsAppTranslationEnginesNewEngineTypeZhCn._(_root);
  @override
  late final _TranslationsAppTranslationEnginesNewSupportInterfaceZhCn
      support_interface =
      _TranslationsAppTranslationEnginesNewSupportInterfaceZhCn._(_root);
  @override
  late final _TranslationsAppTranslationEnginesNewOptionZhCn option =
      _TranslationsAppTranslationEnginesNewOptionZhCn._(_root);
}

// Path: app.translation_targets
class _TranslationsAppTranslationTargetsZhCn
    implements TranslationsAppTranslationTargetsEn {
  _TranslationsAppTranslationTargetsZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsAppTranslationTargetsKNewZhCn kNew =
      _TranslationsAppTranslationTargetsKNewZhCn._(_root);
}

// Path: widget.record_shortcut_dialog
class _TranslationsWidgetRecordShortcutDialogZhCn
    implements TranslationsWidgetRecordShortcutDialogEn {
  _TranslationsWidgetRecordShortcutDialogZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '自定义快捷键';
}

// Path: app.ocr_engines.msg
class _TranslationsAppOcrEnginesMsgZhCn
    implements TranslationsAppOcrEnginesMsgEn {
  _TranslationsAppOcrEnginesMsgZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get no_available_engines => '无可用的引擎';
}

// Path: app.ocr_engines.private
class _TranslationsAppOcrEnginesPrivateZhCn
    implements TranslationsAppOcrEnginesPrivateEn {
  _TranslationsAppOcrEnginesPrivateZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '私有';
}

// Path: app.ocr_engines_new.engine_type
class _TranslationsAppOcrEnginesNewEngineTypeZhCn
    implements TranslationsAppOcrEnginesNewEngineTypeEn {
  _TranslationsAppOcrEnginesNewEngineTypeZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '引擎类型';
}

// Path: app.ocr_engines_new.option
class _TranslationsAppOcrEnginesNewOptionZhCn
    implements TranslationsAppOcrEnginesNewOptionEn {
  _TranslationsAppOcrEnginesNewOptionZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '选项';
}

// Path: app.settings.kLayout
class _TranslationsAppSettingsKLayoutZhCn
    implements TranslationsAppSettingsKLayoutEn {
  _TranslationsAppSettingsKLayoutZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsAppSettingsKLayoutNavgroupZhCn navgroup =
      _TranslationsAppSettingsKLayoutNavgroupZhCn._(_root);
}

// Path: app.settings.about
class _TranslationsAppSettingsAboutZhCn
    implements TranslationsAppSettingsAboutEn {
  _TranslationsAppSettingsAboutZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '关于';
  @override
  late final _TranslationsAppSettingsAboutPackageInfoZhCn package_info =
      _TranslationsAppSettingsAboutPackageInfoZhCn._(_root);
}

// Path: app.settings.advanced
class _TranslationsAppSettingsAdvancedZhCn
    implements TranslationsAppSettingsAdvancedEn {
  _TranslationsAppSettingsAdvancedZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '高级';
  @override
  late final _TranslationsAppSettingsAdvancedLaunchAtLoginZhCn launch_at_login =
      _TranslationsAppSettingsAdvancedLaunchAtLoginZhCn._(_root);
}

// Path: app.settings.appearance
class _TranslationsAppSettingsAppearanceZhCn
    implements TranslationsAppSettingsAppearanceEn {
  _TranslationsAppSettingsAppearanceZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '外观';
  @override
  String get subtitle => '改变你的客户端的外观。';
  @override
  late final _TranslationsAppSettingsAppearanceTrayIconZhCn tray_icon =
      _TranslationsAppSettingsAppearanceTrayIconZhCn._(_root);
  @override
  late final _TranslationsAppSettingsAppearanceMaxWindowHeightZhCn
      max_window_height =
      _TranslationsAppSettingsAppearanceMaxWindowHeightZhCn._(_root);
}

// Path: app.settings.changelog
class _TranslationsAppSettingsChangelogZhCn
    implements TranslationsAppSettingsChangelogEn {
  _TranslationsAppSettingsChangelogZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '变更日志';
  @override
  String get subtitle => '看看我们正在开发哪些很酷的新功能。';
}

// Path: app.settings.general
class _TranslationsAppSettingsGeneralZhCn
    implements TranslationsAppSettingsGeneralEn {
  _TranslationsAppSettingsGeneralZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '通用';
  @override
  String get subtitle => '与客户端相关的通用设置。';
  @override
  late final _TranslationsAppSettingsGeneralDefaultDetectTextEngineZhCn
      default_detect_text_engine =
      _TranslationsAppSettingsGeneralDefaultDetectTextEngineZhCn._(_root);
  @override
  late final _TranslationsAppSettingsGeneralExtractTextZhCn extract_text =
      _TranslationsAppSettingsGeneralExtractTextZhCn._(_root);
  @override
  late final _TranslationsAppSettingsGeneralDefaultTranslateEngineZhCn
      default_translate_engine =
      _TranslationsAppSettingsGeneralDefaultTranslateEngineZhCn._(_root);
  @override
  late final _TranslationsAppSettingsGeneralTranslationModeZhCn
      translation_mode =
      _TranslationsAppSettingsGeneralTranslationModeZhCn._(_root);
  @override
  late final _TranslationsAppSettingsGeneralDefaultDetectLanguageEngineZhCn
      default_detect_language_engine =
      _TranslationsAppSettingsGeneralDefaultDetectLanguageEngineZhCn._(_root);
  @override
  late final _TranslationsAppSettingsGeneralTranslationTargetZhCn
      translation_target =
      _TranslationsAppSettingsGeneralTranslationTargetZhCn._(_root);
  @override
  late final _TranslationsAppSettingsGeneralTranslateZhCn translate =
      _TranslationsAppSettingsGeneralTranslateZhCn._(_root);
  @override
  late final _TranslationsAppSettingsGeneralInputSettingsZhCn input_settings =
      _TranslationsAppSettingsGeneralInputSettingsZhCn._(_root);
}

// Path: app.settings.keybinds
class _TranslationsAppSettingsKeybindsZhCn
    implements TranslationsAppSettingsKeybindsEn {
  _TranslationsAppSettingsKeybindsZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '快捷键';
  @override
  String get subtitle => '查看和管理客户端快捷键。';
  @override
  late final _TranslationsAppSettingsKeybindsWindowZhCn window =
      _TranslationsAppSettingsKeybindsWindowZhCn._(_root);
  @override
  late final _TranslationsAppSettingsKeybindsExtractTextZhCn extract_text =
      _TranslationsAppSettingsKeybindsExtractTextZhCn._(_root);
  @override
  late final _TranslationsAppSettingsKeybindsInputAssistFunctionZhCn
      input_assist_function =
      _TranslationsAppSettingsKeybindsInputAssistFunctionZhCn._(_root);
}

// Path: app.settings.language
class _TranslationsAppSettingsLanguageZhCn
    implements TranslationsAppSettingsLanguageEn {
  _TranslationsAppSettingsLanguageZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '语言';
}

// Path: app.settings.ocr_engines
class _TranslationsAppSettingsOcrEnginesZhCn
    implements TranslationsAppSettingsOcrEnginesEn {
  _TranslationsAppSettingsOcrEnginesZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '文字识别';
  @override
  late final _TranslationsAppSettingsOcrEnginesPrivateZhCn private =
      _TranslationsAppSettingsOcrEnginesPrivateZhCn._(_root);
}

// Path: app.settings.translation_engines
class _TranslationsAppSettingsTranslationEnginesZhCn
    implements TranslationsAppSettingsTranslationEnginesEn {
  _TranslationsAppSettingsTranslationEnginesZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '文本翻译';
  @override
  late final _TranslationsAppSettingsTranslationEnginesPrivateZhCn private =
      _TranslationsAppSettingsTranslationEnginesPrivateZhCn._(_root);
}

// Path: app.supported_languages.all
class _TranslationsAppSupportedLanguagesAllZhCn
    implements TranslationsAppSupportedLanguagesAllEn {
  _TranslationsAppSupportedLanguagesAllZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '全部';
}

// Path: app.translation_engines.msg
class _TranslationsAppTranslationEnginesMsgZhCn
    implements TranslationsAppTranslationEnginesMsgEn {
  _TranslationsAppTranslationEnginesMsgZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get no_available_engines => '无可用的引擎';
}

// Path: app.translation_engines.private
class _TranslationsAppTranslationEnginesPrivateZhCn
    implements TranslationsAppTranslationEnginesPrivateEn {
  _TranslationsAppTranslationEnginesPrivateZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '私有';
}

// Path: app.translation_engines_new.engine_type
class _TranslationsAppTranslationEnginesNewEngineTypeZhCn
    implements TranslationsAppTranslationEnginesNewEngineTypeEn {
  _TranslationsAppTranslationEnginesNewEngineTypeZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '引擎类型';
}

// Path: app.translation_engines_new.support_interface
class _TranslationsAppTranslationEnginesNewSupportInterfaceZhCn
    implements TranslationsAppTranslationEnginesNewSupportInterfaceEn {
  _TranslationsAppTranslationEnginesNewSupportInterfaceZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '支持接口';
}

// Path: app.translation_engines_new.option
class _TranslationsAppTranslationEnginesNewOptionZhCn
    implements TranslationsAppTranslationEnginesNewOptionEn {
  _TranslationsAppTranslationEnginesNewOptionZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '选项';
}

// Path: app.translation_targets.kNew
class _TranslationsAppTranslationTargetsKNewZhCn
    implements TranslationsAppTranslationTargetsKNewEn {
  _TranslationsAppTranslationTargetsKNewZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '添加翻译目标';
  @override
  String get title_with_edit => '编辑翻译目标';
  @override
  String get source_language => '源语言';
  @override
  String get target_language => '目标语言';
}

// Path: app.settings.kLayout.navgroup
class _TranslationsAppSettingsKLayoutNavgroupZhCn
    implements TranslationsAppSettingsKLayoutNavgroupEn {
  _TranslationsAppSettingsKLayoutNavgroupZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get client => '客户端';
  @override
  String get integrations => '服务接入';
  @override
  String get resources => '资源';
}

// Path: app.settings.about.package_info
class _TranslationsAppSettingsAboutPackageInfoZhCn
    implements TranslationsAppSettingsAboutPackageInfoEn {
  _TranslationsAppSettingsAboutPackageInfoZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get version => '版本号';
  @override
  String get build_number => '内部版本号';
}

// Path: app.settings.advanced.launch_at_login
class _TranslationsAppSettingsAdvancedLaunchAtLoginZhCn
    implements TranslationsAppSettingsAdvancedLaunchAtLoginEn {
  _TranslationsAppSettingsAdvancedLaunchAtLoginZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '开机自启动';
}

// Path: app.settings.appearance.tray_icon
class _TranslationsAppSettingsAppearanceTrayIconZhCn
    implements TranslationsAppSettingsAppearanceTrayIconEn {
  _TranslationsAppSettingsAppearanceTrayIconZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '托盘图标';
  @override
  late final _TranslationsAppSettingsAppearanceTrayIconStyleZhCn style =
      _TranslationsAppSettingsAppearanceTrayIconStyleZhCn._(_root);
  @override
  late final _TranslationsAppSettingsAppearanceTrayIconShowZhCn show =
      _TranslationsAppSettingsAppearanceTrayIconShowZhCn._(_root);
}

// Path: app.settings.appearance.max_window_height
class _TranslationsAppSettingsAppearanceMaxWindowHeightZhCn
    implements TranslationsAppSettingsAppearanceMaxWindowHeightEn {
  _TranslationsAppSettingsAppearanceMaxWindowHeightZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '最大窗口高度（逻辑像素）';
}

// Path: app.settings.general.default_detect_text_engine
class _TranslationsAppSettingsGeneralDefaultDetectTextEngineZhCn
    implements TranslationsAppSettingsGeneralDefaultDetectTextEngineEn {
  _TranslationsAppSettingsGeneralDefaultDetectTextEngineZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '默认文字识别引擎';
}

// Path: app.settings.general.extract_text
class _TranslationsAppSettingsGeneralExtractTextZhCn
    implements TranslationsAppSettingsGeneralExtractTextEn {
  _TranslationsAppSettingsGeneralExtractTextZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextZhCn
      auto_copy_detected_text =
      _TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextZhCn._(
          _root);
}

// Path: app.settings.general.default_translate_engine
class _TranslationsAppSettingsGeneralDefaultTranslateEngineZhCn
    implements TranslationsAppSettingsGeneralDefaultTranslateEngineEn {
  _TranslationsAppSettingsGeneralDefaultTranslateEngineZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '默认翻译引擎';
}

// Path: app.settings.general.translation_mode
class _TranslationsAppSettingsGeneralTranslationModeZhCn
    implements TranslationsAppSettingsGeneralTranslationModeEn {
  _TranslationsAppSettingsGeneralTranslationModeZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '翻译模式';
}

// Path: app.settings.general.default_detect_language_engine
class _TranslationsAppSettingsGeneralDefaultDetectLanguageEngineZhCn
    implements TranslationsAppSettingsGeneralDefaultDetectLanguageEngineEn {
  _TranslationsAppSettingsGeneralDefaultDetectLanguageEngineZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '默认语种识别引擎';
}

// Path: app.settings.general.translation_target
class _TranslationsAppSettingsGeneralTranslationTargetZhCn
    implements TranslationsAppSettingsGeneralTranslationTargetEn {
  _TranslationsAppSettingsGeneralTranslationTargetZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '翻译目标';
}

// Path: app.settings.general.translate
class _TranslationsAppSettingsGeneralTranslateZhCn
    implements TranslationsAppSettingsGeneralTranslateEn {
  _TranslationsAppSettingsGeneralTranslateZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultZhCn
      double_click_copy_result =
      _TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultZhCn._(
          _root);
}

// Path: app.settings.general.input_settings
class _TranslationsAppSettingsGeneralInputSettingsZhCn
    implements TranslationsAppSettingsGeneralInputSettingsEn {
  _TranslationsAppSettingsGeneralInputSettingsZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '输入设置';
  @override
  late final _TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterZhCn
      submit_with_enter =
      _TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterZhCn._(_root);
  @override
  late final _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterZhCn
      submit_with_meta_enter =
      _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterZhCn._(
          _root);
  @override
  late final _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacZhCn
      submit_with_meta_enter_mac =
      _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacZhCn._(
          _root);
}

// Path: app.settings.keybinds.window
class _TranslationsAppSettingsKeybindsWindowZhCn
    implements TranslationsAppSettingsKeybindsWindowEn {
  _TranslationsAppSettingsKeybindsWindowZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsAppSettingsKeybindsWindowShowOrHideZhCn show_or_hide =
      _TranslationsAppSettingsKeybindsWindowShowOrHideZhCn._(_root);
  @override
  late final _TranslationsAppSettingsKeybindsWindowHideZhCn hide =
      _TranslationsAppSettingsKeybindsWindowHideZhCn._(_root);
}

// Path: app.settings.keybinds.extract_text
class _TranslationsAppSettingsKeybindsExtractTextZhCn
    implements TranslationsAppSettingsKeybindsExtractTextEn {
  _TranslationsAppSettingsKeybindsExtractTextZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '屏幕/剪切板取词';
  @override
  late final _TranslationsAppSettingsKeybindsExtractTextFromSelectionZhCn
      from_selection =
      _TranslationsAppSettingsKeybindsExtractTextFromSelectionZhCn._(_root);
  @override
  late final _TranslationsAppSettingsKeybindsExtractTextFromCaptureZhCn
      from_capture =
      _TranslationsAppSettingsKeybindsExtractTextFromCaptureZhCn._(_root);
  @override
  late final _TranslationsAppSettingsKeybindsExtractTextFromClipboardZhCn
      from_clipboard =
      _TranslationsAppSettingsKeybindsExtractTextFromClipboardZhCn._(_root);
}

// Path: app.settings.keybinds.input_assist_function
class _TranslationsAppSettingsKeybindsInputAssistFunctionZhCn
    implements TranslationsAppSettingsKeybindsInputAssistFunctionEn {
  _TranslationsAppSettingsKeybindsInputAssistFunctionZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '输入辅助功能';
  @override
  late final _TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentZhCn
      translate_input_content =
      _TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentZhCn
          ._(_root);
}

// Path: app.settings.ocr_engines.private
class _TranslationsAppSettingsOcrEnginesPrivateZhCn
    implements TranslationsAppSettingsOcrEnginesPrivateEn {
  _TranslationsAppSettingsOcrEnginesPrivateZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '私有';
  @override
  String get description => '长按项目以重新排序';
}

// Path: app.settings.translation_engines.private
class _TranslationsAppSettingsTranslationEnginesPrivateZhCn
    implements TranslationsAppSettingsTranslationEnginesPrivateEn {
  _TranslationsAppSettingsTranslationEnginesPrivateZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '私有';
  @override
  String get description => '长按项目以重新排序';
}

// Path: app.settings.appearance.tray_icon.style
class _TranslationsAppSettingsAppearanceTrayIconStyleZhCn
    implements TranslationsAppSettingsAppearanceTrayIconStyleEn {
  _TranslationsAppSettingsAppearanceTrayIconStyleZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '托盘图标样式';
}

// Path: app.settings.appearance.tray_icon.show
class _TranslationsAppSettingsAppearanceTrayIconShowZhCn
    implements TranslationsAppSettingsAppearanceTrayIconShowEn {
  _TranslationsAppSettingsAppearanceTrayIconShowZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '显示托盘图标';
}

// Path: app.settings.general.extract_text.auto_copy_detected_text
class _TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextZhCn
    implements TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextEn {
  _TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextZhCn._(
      this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '自动复制检测到的文本';
}

// Path: app.settings.general.translate.double_click_copy_result
class _TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultZhCn
    implements TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultEn {
  _TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultZhCn._(
      this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '双击复制翻译结果';
}

// Path: app.settings.general.input_settings.submit_with_enter
class _TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterZhCn
    implements TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterEn {
  _TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '用 Enter 提交';
}

// Path: app.settings.general.input_settings.submit_with_meta_enter
class _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterZhCn
    implements
        TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterEn {
  _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterZhCn._(
      this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '用 Ctrl + Enter 提交';
}

// Path: app.settings.general.input_settings.submit_with_meta_enter_mac
class _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacZhCn
    implements
        TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacEn {
  _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacZhCn._(
      this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '用 ⌘ + Enter 提交';
}

// Path: app.settings.keybinds.window.show_or_hide
class _TranslationsAppSettingsKeybindsWindowShowOrHideZhCn
    implements TranslationsAppSettingsKeybindsWindowShowOrHideEn {
  _TranslationsAppSettingsKeybindsWindowShowOrHideZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '显示/隐藏';
}

// Path: app.settings.keybinds.window.hide
class _TranslationsAppSettingsKeybindsWindowHideZhCn
    implements TranslationsAppSettingsKeybindsWindowHideEn {
  _TranslationsAppSettingsKeybindsWindowHideZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '隐藏';
}

// Path: app.settings.keybinds.extract_text.from_selection
class _TranslationsAppSettingsKeybindsExtractTextFromSelectionZhCn
    implements TranslationsAppSettingsKeybindsExtractTextFromSelectionEn {
  _TranslationsAppSettingsKeybindsExtractTextFromSelectionZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '选中文字';
}

// Path: app.settings.keybinds.extract_text.from_capture
class _TranslationsAppSettingsKeybindsExtractTextFromCaptureZhCn
    implements TranslationsAppSettingsKeybindsExtractTextFromCaptureEn {
  _TranslationsAppSettingsKeybindsExtractTextFromCaptureZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '截取区域';
}

// Path: app.settings.keybinds.extract_text.from_clipboard
class _TranslationsAppSettingsKeybindsExtractTextFromClipboardZhCn
    implements TranslationsAppSettingsKeybindsExtractTextFromClipboardEn {
  _TranslationsAppSettingsKeybindsExtractTextFromClipboardZhCn._(this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '剪切板';
}

// Path: app.settings.keybinds.input_assist_function.translate_input_content
class _TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentZhCn
    implements
        TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentEn {
  _TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentZhCn._(
      this._root);

  final TranslationsZhCn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '翻译当前输入框内容';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsZhCn {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'app_name':
        return '比译';
      case 'ok':
        return '确定';
      case 'cancel':
        return '取消';
      case 'add':
        return '添加';
      case 'delete':
        return '删除';
      case 'copied':
        return '已复制';
      case 'please_choose':
        return '请选择';
      case 'language.af':
        return '布尔语(南非荷兰语)';
      case 'language.am':
        return '阿姆哈拉语';
      case 'language.ar':
        return '阿拉伯语';
      case 'language.az':
        return '阿塞拜疆语';
      case 'language.be':
        return '白俄罗斯语';
      case 'language.bg':
        return '保加利亚语';
      case 'language.bn':
        return '孟加拉语';
      case 'language.bs':
        return '波斯尼亚语';
      case 'language.ca':
        return '加泰罗尼亚语';
      case 'language.ceb':
        return '宿务语';
      case 'language.co':
        return '科西嘉语';
      case 'language.cs':
        return '捷克语';
      case 'language.cy':
        return '威尔士语';
      case 'language.da':
        return '丹麦语';
      case 'language.de':
        return '德语';
      case 'language.el':
        return '希腊语';
      case 'language.en':
        return '英语';
      case 'language.eo':
        return '世界语';
      case 'language.es':
        return '西班牙语';
      case 'language.et':
        return '爱沙尼亚语';
      case 'language.eu':
        return '巴斯克语';
      case 'language.fa':
        return '波斯语';
      case 'language.fi':
        return '芬兰语';
      case 'language.fr':
        return '法语';
      case 'language.fy':
        return '弗里西语';
      case 'language.ga':
        return '爱尔兰语';
      case 'language.gd':
        return '苏格兰盖尔语';
      case 'language.gl':
        return '加利西亚语';
      case 'language.gu':
        return '古吉拉特语';
      case 'language.ha':
        return '豪萨语';
      case 'language.haw':
        return '夏威夷语';
      case 'language.he':
        return '希伯来语';
      case 'language.hi':
        return '印地语';
      case 'language.hmn':
        return '苗语';
      case 'language.hr':
        return '克罗地亚语';
      case 'language.ht':
        return '海地克里奥尔语';
      case 'language.hu':
        return '匈牙利语';
      case 'language.hy':
        return '亚美尼亚语';
      case 'language.id':
        return '印尼语';
      case 'language.ig':
        return '伊博语';
      case 'language.kIs':
        return '冰岛语';
      case 'language.it':
        return '意大利语';
      case 'language.iw':
        return '希伯来语';
      case 'language.ja':
        return '日语';
      case 'language.jw':
        return '印尼爪哇语';
      case 'language.ka':
        return '格鲁吉亚语';
      case 'language.kk':
        return '哈萨克语';
      case 'language.km':
        return '高棉语';
      case 'language.kn':
        return '卡纳达语';
      case 'language.ko':
        return '韩语';
      case 'language.ku':
        return '库尔德语';
      case 'language.ky':
        return '吉尔吉斯语';
      case 'language.la':
        return '拉丁语';
      case 'language.lb':
        return '卢森堡语';
      case 'language.lo':
        return '老挝语';
      case 'language.lt':
        return '立陶宛语';
      case 'language.lv':
        return '拉脱维亚语';
      case 'language.mg':
        return '马尔加什语';
      case 'language.mi':
        return '毛利语';
      case 'language.mk':
        return '马其顿语';
      case 'language.ml':
        return '马拉雅拉姆语';
      case 'language.mn':
        return '蒙古语';
      case 'language.mr':
        return '马拉地语';
      case 'language.ms':
        return '马来语';
      case 'language.mt':
        return '马耳他语';
      case 'language.my':
        return '缅甸语';
      case 'language.ne':
        return '尼泊尔语';
      case 'language.nl':
        return '荷兰语';
      case 'language.no':
        return '挪威语';
      case 'language.ny':
        return '齐切瓦语';
      case 'language.or':
        return '奥利亚语';
      case 'language.pa':
        return '旁遮普语';
      case 'language.pl':
        return '波兰语';
      case 'language.ps':
        return '普什图语';
      case 'language.pt':
        return '葡萄牙语';
      case 'language.ro':
        return '罗马尼亚语';
      case 'language.ru':
        return '俄语';
      case 'language.rw':
        return '卢旺达语';
      case 'language.sd':
        return '信德语';
      case 'language.si':
        return '僧伽罗语';
      case 'language.sk':
        return '斯洛伐克语';
      case 'language.sl':
        return '斯洛文尼亚语';
      case 'language.sm':
        return '萨摩亚语';
      case 'language.sn':
        return '修纳语';
      case 'language.so':
        return '索马里语';
      case 'language.sq':
        return '阿尔巴尼亚语';
      case 'language.sr':
        return '塞尔维亚语';
      case 'language.st':
        return '塞索托语';
      case 'language.su':
        return '印尼巽他语';
      case 'language.sv':
        return '瑞典语';
      case 'language.sw':
        return '斯瓦希里语';
      case 'language.ta':
        return '泰米尔语';
      case 'language.te':
        return '泰卢固语';
      case 'language.tg':
        return '塔吉克语';
      case 'language.th':
        return '泰语';
      case 'language.tk':
        return '土库曼语';
      case 'language.tl':
        return '菲律宾语';
      case 'language.tr':
        return '土耳其语';
      case 'language.tt':
        return '鞑靼语';
      case 'language.ug':
        return '维吾尔语';
      case 'language.uk':
        return '乌克兰语';
      case 'language.ur':
        return '乌尔都语';
      case 'language.uz':
        return '乌兹别克语';
      case 'language.vi':
        return '越南语';
      case 'language.xh':
        return '南非科萨语';
      case 'language.yi':
        return '意第绪语';
      case 'language.yo':
        return '约鲁巴语';
      case 'language.zh':
        return '中文';
      case 'language.zh_CN':
        return '中文';
      case 'language.zh_TW':
        return '中文(繁体)';
      case 'language.zu':
        return '南非祖鲁语';
      case 'engine.baidu':
        return '百度翻译';
      case 'engine.caiyun':
        return '彩云小译';
      case 'engine.deepl':
        return 'DeepL';
      case 'engine.google':
        return '谷歌翻译';
      case 'engine.ibmwatson':
        return 'IBMWatson';
      case 'engine.iciba':
        return '爱词霸';
      case 'engine.openai':
        return 'OpenAI';
      case 'engine.sogou':
        return '搜狗翻译';
      case 'engine.tencent':
        return '腾讯翻译君';
      case 'engine.youdao':
        return '有道翻译';
      case 'engine_scope.detectlanguage':
        return '语种识别';
      case 'engine_scope.lookup':
        return '查词';
      case 'engine_scope.translate':
        return '翻译';
      case 'ocr_engine.built_in':
        return '内置';
      case 'ocr_engine.tesseract':
        return 'Tesseract OCR';
      case 'ocr_engine.youdao':
        return '有道通用文字识别';
      case 'translation_mode.auto':
        return '自动';
      case 'translation_mode.manual':
        return '手动';
      case 'theme_mode.light':
        return '浅色';
      case 'theme_mode.dark':
        return '深色';
      case 'theme_mode.system':
        return '跟随系统';
      case 'word_pronunciation.us':
        return '美';
      case 'word_pronunciation.uk':
        return '英';
      case 'tray_context_menu.item_show':
        return '显示';
      case 'tray_context_menu.item_quick_start_guide':
        return '快速入门';
      case 'tray_context_menu.item_discussion':
        return '加入讨论';
      case 'tray_context_menu.item_quit_app':
        return '退出比译';
      case 'tray_context_menu.item_discussion_subitem_discord_server':
        return '加入 Discord';
      case 'tray_context_menu.item_discussion_subitem_qq_group':
        return '加入 QQ 群';
      case 'app.home.newversion_banner_text_found_new_version':
        return ({required Object version}) => '发现新版本：${version}';
      case 'app.home.newversion_banner_btn_update':
        return '立即更新';
      case 'app.home.limited_banner_title':
        return '功能受限，请根据提示进行检查。';
      case 'app.home.limited_banner_text_screen_capture':
        return '授予屏幕录制权限';
      case 'app.home.limited_banner_text_screen_selection':
        return '授予辅助功能权限';
      case 'app.home.limited_banner_btn_allow':
        return '允许';
      case 'app.home.limited_banner_btn_go_settings':
        return '前往设置';
      case 'app.home.limited_banner_btn_check_again':
        return '重新检查';
      case 'app.home.limited_banner_tip_help':
        return '查看帮助文档';
      case 'app.home.limited_banner_msg_allow_access_tip':
        return '点击「授权」后如无任何响应，请点击「前往设置」进行手动设置。';
      case 'app.home.limited_banner_msg_all_access_allowed':
        return '屏幕取词功能已启用';
      case 'app.home.limited_banner_msg_all_access_not_allowed':
        return '未获得所需权限，\n请重新检查并进行设置。';
      case 'app.home.input_hint':
        return '在此处输入单词或文本';
      case 'app.home.text_extracting_text':
        return '正在提取文字...';
      case 'app.home.tip_translation_mode':
        return ({required Object mode}) => '当前翻译模式：${mode}';
      case 'app.home.tip_extract_text_from_screen_capture':
        return '截取屏幕区域并识别文字';
      case 'app.home.tip_extract_text_from_clipboard':
        return '读取剪切板内容';
      case 'app.home.btn_clear':
        return '清空';
      case 'app.home.btn_trans':
        return '翻译';
      case 'app.home.msg_please_enter_word_or_text':
        return '未输入或未提取到文本';
      case 'app.home.msg_capture_screen_area_canceled':
        return '截取屏幕区域已取消';
      case 'app.record_shortcut.title':
        return '录制你的快捷键';
      case 'app.ocr_engine_types.title':
        return '引擎类型';
      case 'app.ocr_engines.title':
        return '文字识别引擎';
      case 'app.ocr_engines.msg.no_available_engines':
        return '无可用的引擎';
      case 'app.ocr_engines.private.title':
        return '私有';
      case 'app.ocr_engines_new.title':
        return '添加文字识别引擎';
      case 'app.ocr_engines_new.engine_type.title':
        return '引擎类型';
      case 'app.ocr_engines_new.option.title':
        return '选项';
      case 'app.settings.title':
        return 'Settings';
      case 'app.settings.text_version':
        return ({required Object version, required Object buildNumber}) =>
            'Version ${version} BUILD ${buildNumber}';
      case 'app.settings.kLayout.navgroup.client':
        return '客户端';
      case 'app.settings.kLayout.navgroup.integrations':
        return '服务接入';
      case 'app.settings.kLayout.navgroup.resources':
        return '资源';
      case 'app.settings.about.title':
        return '关于';
      case 'app.settings.about.package_info.version':
        return '版本号';
      case 'app.settings.about.package_info.build_number':
        return '内部版本号';
      case 'app.settings.advanced.title':
        return '高级';
      case 'app.settings.advanced.launch_at_login.title':
        return '开机自启动';
      case 'app.settings.appearance.title':
        return '外观';
      case 'app.settings.appearance.subtitle':
        return '改变你的客户端的外观。';
      case 'app.settings.appearance.tray_icon.title':
        return '托盘图标';
      case 'app.settings.appearance.tray_icon.style.title':
        return '托盘图标样式';
      case 'app.settings.appearance.tray_icon.show.title':
        return '显示托盘图标';
      case 'app.settings.appearance.max_window_height.title':
        return '最大窗口高度（逻辑像素）';
      case 'app.settings.changelog.title':
        return '变更日志';
      case 'app.settings.changelog.subtitle':
        return '看看我们正在开发哪些很酷的新功能。';
      case 'app.settings.general.title':
        return '通用';
      case 'app.settings.general.subtitle':
        return '与客户端相关的通用设置。';
      case 'app.settings.general.default_detect_text_engine.title':
        return '默认文字识别引擎';
      case 'app.settings.general.extract_text.auto_copy_detected_text.title':
        return '自动复制检测到的文本';
      case 'app.settings.general.default_translate_engine.title':
        return '默认翻译引擎';
      case 'app.settings.general.translation_mode.title':
        return '翻译模式';
      case 'app.settings.general.default_detect_language_engine.title':
        return '默认语种识别引擎';
      case 'app.settings.general.translation_target.title':
        return '翻译目标';
      case 'app.settings.general.translate.double_click_copy_result.title':
        return '双击复制翻译结果';
      case 'app.settings.general.input_settings.title':
        return '输入设置';
      case 'app.settings.general.input_settings.submit_with_enter.title':
        return '用 Enter 提交';
      case 'app.settings.general.input_settings.submit_with_meta_enter.title':
        return '用 Ctrl + Enter 提交';
      case 'app.settings.general.input_settings.submit_with_meta_enter_mac.title':
        return '用 ⌘ + Enter 提交';
      case 'app.settings.keybinds.title':
        return '快捷键';
      case 'app.settings.keybinds.subtitle':
        return '查看和管理客户端快捷键。';
      case 'app.settings.keybinds.window.show_or_hide.title':
        return '显示/隐藏';
      case 'app.settings.keybinds.window.hide.title':
        return '隐藏';
      case 'app.settings.keybinds.extract_text.title':
        return '屏幕/剪切板取词';
      case 'app.settings.keybinds.extract_text.from_selection.title':
        return '选中文字';
      case 'app.settings.keybinds.extract_text.from_capture.title':
        return '截取区域';
      case 'app.settings.keybinds.extract_text.from_clipboard.title':
        return '剪切板';
      case 'app.settings.keybinds.input_assist_function.title':
        return '输入辅助功能';
      case 'app.settings.keybinds.input_assist_function.translate_input_content.title':
        return '翻译当前输入框内容';
      case 'app.settings.language.title':
        return '语言';
      case 'app.settings.ocr_engines.title':
        return '文字识别';
      case 'app.settings.ocr_engines.private.title':
        return '私有';
      case 'app.settings.ocr_engines.private.description':
        return '长按项目以重新排序';
      case 'app.settings.translation_engines.title':
        return '文本翻译';
      case 'app.settings.translation_engines.private.title':
        return '私有';
      case 'app.settings.translation_engines.private.description':
        return '长按项目以重新排序';
      case 'app.supported_languages.title':
        return '支持的语言';
      case 'app.supported_languages.all.title':
        return '全部';
      case 'app.translation_engine_types.title':
        return '引擎类型';
      case 'app.translation_engines.title':
        return '文本翻译引擎';
      case 'app.translation_engines.msg.no_available_engines':
        return '无可用的引擎';
      case 'app.translation_engines.private.title':
        return '私有';
      case 'app.translation_engines_new.title':
        return '添加文本翻译引擎';
      case 'app.translation_engines_new.engine_type.title':
        return '引擎类型';
      case 'app.translation_engines_new.support_interface.title':
        return '支持接口';
      case 'app.translation_engines_new.option.title':
        return '选项';
      case 'app.translation_targets.kNew.title':
        return '添加翻译目标';
      case 'app.translation_targets.kNew.title_with_edit':
        return '编辑翻译目标';
      case 'app.translation_targets.kNew.source_language':
        return '源语言';
      case 'app.translation_targets.kNew.target_language':
        return '目标语言';
      case 'widget.record_shortcut_dialog.title':
        return '自定义快捷键';
      default:
        return null;
    }
  }
}
