///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsZhCn with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhCn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhCn,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-CN>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhCn _root = this; // ignore: unused_field

	@override 
	TranslationsZhCn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhCn(meta: meta ?? this.$meta);

	// Translations
	@override String get app_name => '比译';
	@override String get ok => '确定';
	@override String get cancel => '取消';
	@override String get add => '添加';
	@override String get delete => '删除';
	@override String get copied => '已复制';
	@override String get please_choose => '请选择';
	@override late final _TranslationsLanguageZhCn language = _TranslationsLanguageZhCn._(_root);
	@override late final _TranslationsEngineZhCn engine = _TranslationsEngineZhCn._(_root);
	@override late final _TranslationsEngineScopeZhCn engine_scope = _TranslationsEngineScopeZhCn._(_root);
	@override late final _TranslationsOcrEngineZhCn ocr_engine = _TranslationsOcrEngineZhCn._(_root);
	@override late final _TranslationsTranslationModeZhCn translation_mode = _TranslationsTranslationModeZhCn._(_root);
	@override late final _TranslationsThemeModeZhCn theme_mode = _TranslationsThemeModeZhCn._(_root);
	@override late final _TranslationsWordPronunciationZhCn word_pronunciation = _TranslationsWordPronunciationZhCn._(_root);
	@override late final _TranslationsTrayContextMenuZhCn tray_context_menu = _TranslationsTrayContextMenuZhCn._(_root);
	@override late final _TranslationsAppZhCn app = _TranslationsAppZhCn._(_root);
	@override late final _TranslationsWidgetZhCn widget = _TranslationsWidgetZhCn._(_root);
}

// Path: language
class _TranslationsLanguageZhCn implements TranslationsLanguageEn {
	_TranslationsLanguageZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get af => '布尔语(南非荷兰语)';
	@override String get am => '阿姆哈拉语';
	@override String get ar => '阿拉伯语';
	@override String get az => '阿塞拜疆语';
	@override String get be => '白俄罗斯语';
	@override String get bg => '保加利亚语';
	@override String get bn => '孟加拉语';
	@override String get bs => '波斯尼亚语';
	@override String get ca => '加泰罗尼亚语';
	@override String get ceb => '宿务语';
	@override String get co => '科西嘉语';
	@override String get cs => '捷克语';
	@override String get cy => '威尔士语';
	@override String get da => '丹麦语';
	@override String get de => '德语';
	@override String get el => '希腊语';
	@override String get en => '英语';
	@override String get eo => '世界语';
	@override String get es => '西班牙语';
	@override String get et => '爱沙尼亚语';
	@override String get eu => '巴斯克语';
	@override String get fa => '波斯语';
	@override String get fi => '芬兰语';
	@override String get fr => '法语';
	@override String get fy => '弗里西语';
	@override String get ga => '爱尔兰语';
	@override String get gd => '苏格兰盖尔语';
	@override String get gl => '加利西亚语';
	@override String get gu => '古吉拉特语';
	@override String get ha => '豪萨语';
	@override String get haw => '夏威夷语';
	@override String get he => '希伯来语';
	@override String get hi => '印地语';
	@override String get hmn => '苗语';
	@override String get hr => '克罗地亚语';
	@override String get ht => '海地克里奥尔语';
	@override String get hu => '匈牙利语';
	@override String get hy => '亚美尼亚语';
	@override String get id => '印尼语';
	@override String get ig => '伊博语';
	@override String get kIs => '冰岛语';
	@override String get it => '意大利语';
	@override String get iw => '希伯来语';
	@override String get ja => '日语';
	@override String get jw => '印尼爪哇语';
	@override String get ka => '格鲁吉亚语';
	@override String get kk => '哈萨克语';
	@override String get km => '高棉语';
	@override String get kn => '卡纳达语';
	@override String get ko => '韩语';
	@override String get ku => '库尔德语';
	@override String get ky => '吉尔吉斯语';
	@override String get la => '拉丁语';
	@override String get lb => '卢森堡语';
	@override String get lo => '老挝语';
	@override String get lt => '立陶宛语';
	@override String get lv => '拉脱维亚语';
	@override String get mg => '马尔加什语';
	@override String get mi => '毛利语';
	@override String get mk => '马其顿语';
	@override String get ml => '马拉雅拉姆语';
	@override String get mn => '蒙古语';
	@override String get mr => '马拉地语';
	@override String get ms => '马来语';
	@override String get mt => '马耳他语';
	@override String get my => '缅甸语';
	@override String get ne => '尼泊尔语';
	@override String get nl => '荷兰语';
	@override String get no => '挪威语';
	@override String get ny => '齐切瓦语';
	@override String get or => '奥利亚语';
	@override String get pa => '旁遮普语';
	@override String get pl => '波兰语';
	@override String get ps => '普什图语';
	@override String get pt => '葡萄牙语';
	@override String get ro => '罗马尼亚语';
	@override String get ru => '俄语';
	@override String get rw => '卢旺达语';
	@override String get sd => '信德语';
	@override String get si => '僧伽罗语';
	@override String get sk => '斯洛伐克语';
	@override String get sl => '斯洛文尼亚语';
	@override String get sm => '萨摩亚语';
	@override String get sn => '修纳语';
	@override String get so => '索马里语';
	@override String get sq => '阿尔巴尼亚语';
	@override String get sr => '塞尔维亚语';
	@override String get st => '塞索托语';
	@override String get su => '印尼巽他语';
	@override String get sv => '瑞典语';
	@override String get sw => '斯瓦希里语';
	@override String get ta => '泰米尔语';
	@override String get te => '泰卢固语';
	@override String get tg => '塔吉克语';
	@override String get th => '泰语';
	@override String get tk => '土库曼语';
	@override String get tl => '菲律宾语';
	@override String get tr => '土耳其语';
	@override String get tt => '鞑靼语';
	@override String get ug => '维吾尔语';
	@override String get uk => '乌克兰语';
	@override String get ur => '乌尔都语';
	@override String get uz => '乌兹别克语';
	@override String get vi => '越南语';
	@override String get xh => '南非科萨语';
	@override String get yi => '意第绪语';
	@override String get yo => '约鲁巴语';
	@override String get zh => '中文';
	@override String get zh_CN => '中文';
	@override String get zh_TW => '中文(繁体)';
	@override String get zu => '南非祖鲁语';
}

// Path: engine
class _TranslationsEngineZhCn implements TranslationsEngineEn {
	_TranslationsEngineZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get baidu => '百度翻译';
	@override String get caiyun => '彩云小译';
	@override String get deepl => 'DeepL';
	@override String get google => '谷歌翻译';
	@override String get ibmwatson => 'IBMWatson';
	@override String get iciba => '爱词霸';
	@override String get openai => 'OpenAI';
	@override String get sogou => '搜狗翻译';
	@override String get tencent => '腾讯翻译君';
	@override String get youdao => '有道翻译';
}

// Path: engine_scope
class _TranslationsEngineScopeZhCn implements TranslationsEngineScopeEn {
	_TranslationsEngineScopeZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get detectlanguage => '语种识别';
	@override String get lookup => '查词';
	@override String get translate => '翻译';
}

// Path: ocr_engine
class _TranslationsOcrEngineZhCn implements TranslationsOcrEngineEn {
	_TranslationsOcrEngineZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get built_in => '内置';
	@override String get tesseract => 'Tesseract OCR';
	@override String get youdao => '有道通用文字识别';
}

// Path: translation_mode
class _TranslationsTranslationModeZhCn implements TranslationsTranslationModeEn {
	_TranslationsTranslationModeZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get auto => '自动';
	@override String get manual => '手动';
}

// Path: theme_mode
class _TranslationsThemeModeZhCn implements TranslationsThemeModeEn {
	_TranslationsThemeModeZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get light => '浅色';
	@override String get dark => '深色';
	@override String get system => '跟随系统';
}

// Path: word_pronunciation
class _TranslationsWordPronunciationZhCn implements TranslationsWordPronunciationEn {
	_TranslationsWordPronunciationZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get us => '美';
	@override String get uk => '英';
}

// Path: tray_context_menu
class _TranslationsTrayContextMenuZhCn implements TranslationsTrayContextMenuEn {
	_TranslationsTrayContextMenuZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get item_show => '显示';
	@override String get item_quick_start_guide => '快速入门';
	@override String get item_discussion => '加入讨论';
	@override String get item_quit_app => '退出比译';
	@override String get item_discussion_subitem_discord_server => '加入 Discord';
	@override String get item_discussion_subitem_qq_group => '加入 QQ 群';
}

// Path: app
class _TranslationsAppZhCn implements TranslationsAppEn {
	_TranslationsAppZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppHomeZhCn home = _TranslationsAppHomeZhCn._(_root);
	@override late final _TranslationsAppRecordShortcutZhCn record_shortcut = _TranslationsAppRecordShortcutZhCn._(_root);
	@override late final _TranslationsAppOcrEngineTypesZhCn ocr_engine_types = _TranslationsAppOcrEngineTypesZhCn._(_root);
	@override late final _TranslationsAppOcrEnginesZhCn ocr_engines = _TranslationsAppOcrEnginesZhCn._(_root);
	@override late final _TranslationsAppOcrEnginesNewZhCn ocr_engines_new = _TranslationsAppOcrEnginesNewZhCn._(_root);
	@override late final _TranslationsAppSettingsZhCn settings = _TranslationsAppSettingsZhCn._(_root);
	@override late final _TranslationsAppSupportedLanguagesZhCn supported_languages = _TranslationsAppSupportedLanguagesZhCn._(_root);
	@override late final _TranslationsAppTranslationEngineTypesZhCn translation_engine_types = _TranslationsAppTranslationEngineTypesZhCn._(_root);
	@override late final _TranslationsAppTranslationEnginesZhCn translation_engines = _TranslationsAppTranslationEnginesZhCn._(_root);
	@override late final _TranslationsAppTranslationEnginesNewZhCn translation_engines_new = _TranslationsAppTranslationEnginesNewZhCn._(_root);
	@override late final _TranslationsAppTranslationTargetsZhCn translation_targets = _TranslationsAppTranslationTargetsZhCn._(_root);
}

// Path: widget
class _TranslationsWidgetZhCn implements TranslationsWidgetEn {
	_TranslationsWidgetZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsWidgetRecordShortcutDialogZhCn record_shortcut_dialog = _TranslationsWidgetRecordShortcutDialogZhCn._(_root);
}

// Path: app.home
class _TranslationsAppHomeZhCn implements TranslationsAppHomeEn {
	_TranslationsAppHomeZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String newversion_banner_text_found_new_version({required Object version}) => '发现新版本：${version}';
	@override String get newversion_banner_btn_update => '立即更新';
	@override String get limited_banner_title => '功能受限，请根据提示进行检查。';
	@override String get limited_banner_text_screen_capture => '授予屏幕录制权限';
	@override String get limited_banner_text_screen_selection => '授予辅助功能权限';
	@override String get limited_banner_btn_allow => '允许';
	@override String get limited_banner_btn_go_settings => '前往设置';
	@override String get limited_banner_btn_check_again => '重新检查';
	@override String get limited_banner_tip_help => '查看帮助文档';
	@override String get limited_banner_msg_allow_access_tip => '点击「授权」后如无任何响应，请点击「前往设置」进行手动设置。';
	@override String get limited_banner_msg_all_access_allowed => '屏幕取词功能已启用';
	@override String get limited_banner_msg_all_access_not_allowed => '未获得所需权限，\n请重新检查并进行设置。';
	@override String get input_hint => '在此处输入单词或文本';
	@override String get text_extracting_text => '正在提取文字...';
	@override String tip_translation_mode({required Object mode}) => '当前翻译模式：${mode}';
	@override String get tip_extract_text_from_screen_capture => '截取屏幕区域并识别文字';
	@override String get tip_extract_text_from_clipboard => '读取剪切板内容';
	@override String get btn_clear => '清空';
	@override String get btn_trans => '翻译';
	@override String get msg_please_enter_word_or_text => '未输入或未提取到文本';
	@override String get msg_capture_screen_area_canceled => '截取屏幕区域已取消';
}

// Path: app.record_shortcut
class _TranslationsAppRecordShortcutZhCn implements TranslationsAppRecordShortcutEn {
	_TranslationsAppRecordShortcutZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '录制你的快捷键';
}

// Path: app.ocr_engine_types
class _TranslationsAppOcrEngineTypesZhCn implements TranslationsAppOcrEngineTypesEn {
	_TranslationsAppOcrEngineTypesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '引擎类型';
}

// Path: app.ocr_engines
class _TranslationsAppOcrEnginesZhCn implements TranslationsAppOcrEnginesEn {
	_TranslationsAppOcrEnginesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '文字识别引擎';
	@override late final _TranslationsAppOcrEnginesMsgZhCn msg = _TranslationsAppOcrEnginesMsgZhCn._(_root);
	@override late final _TranslationsAppOcrEnginesPrivateZhCn private = _TranslationsAppOcrEnginesPrivateZhCn._(_root);
}

// Path: app.ocr_engines_new
class _TranslationsAppOcrEnginesNewZhCn implements TranslationsAppOcrEnginesNewEn {
	_TranslationsAppOcrEnginesNewZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '添加文字识别引擎';
	@override late final _TranslationsAppOcrEnginesNewEngineTypeZhCn engine_type = _TranslationsAppOcrEnginesNewEngineTypeZhCn._(_root);
	@override late final _TranslationsAppOcrEnginesNewOptionZhCn option = _TranslationsAppOcrEnginesNewOptionZhCn._(_root);
}

// Path: app.settings
class _TranslationsAppSettingsZhCn implements TranslationsAppSettingsEn {
	_TranslationsAppSettingsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Settings';
	@override String text_version({required Object version, required Object buildNumber}) => 'Version ${version} BUILD ${buildNumber}';
	@override late final _TranslationsAppSettingsKLayoutZhCn kLayout = _TranslationsAppSettingsKLayoutZhCn._(_root);
	@override late final _TranslationsAppSettingsAboutZhCn about = _TranslationsAppSettingsAboutZhCn._(_root);
	@override late final _TranslationsAppSettingsAdvancedZhCn advanced = _TranslationsAppSettingsAdvancedZhCn._(_root);
	@override late final _TranslationsAppSettingsAppearanceZhCn appearance = _TranslationsAppSettingsAppearanceZhCn._(_root);
	@override late final _TranslationsAppSettingsChangelogZhCn changelog = _TranslationsAppSettingsChangelogZhCn._(_root);
	@override late final _TranslationsAppSettingsGeneralZhCn general = _TranslationsAppSettingsGeneralZhCn._(_root);
	@override late final _TranslationsAppSettingsKeybindsZhCn keybinds = _TranslationsAppSettingsKeybindsZhCn._(_root);
	@override late final _TranslationsAppSettingsLanguageZhCn language = _TranslationsAppSettingsLanguageZhCn._(_root);
	@override late final _TranslationsAppSettingsOcrEnginesZhCn ocr_engines = _TranslationsAppSettingsOcrEnginesZhCn._(_root);
	@override late final _TranslationsAppSettingsTranslationEnginesZhCn translation_engines = _TranslationsAppSettingsTranslationEnginesZhCn._(_root);
}

// Path: app.supported_languages
class _TranslationsAppSupportedLanguagesZhCn implements TranslationsAppSupportedLanguagesEn {
	_TranslationsAppSupportedLanguagesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '支持的语言';
	@override late final _TranslationsAppSupportedLanguagesAllZhCn all = _TranslationsAppSupportedLanguagesAllZhCn._(_root);
}

// Path: app.translation_engine_types
class _TranslationsAppTranslationEngineTypesZhCn implements TranslationsAppTranslationEngineTypesEn {
	_TranslationsAppTranslationEngineTypesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '引擎类型';
}

// Path: app.translation_engines
class _TranslationsAppTranslationEnginesZhCn implements TranslationsAppTranslationEnginesEn {
	_TranslationsAppTranslationEnginesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '文本翻译引擎';
	@override late final _TranslationsAppTranslationEnginesMsgZhCn msg = _TranslationsAppTranslationEnginesMsgZhCn._(_root);
	@override late final _TranslationsAppTranslationEnginesPrivateZhCn private = _TranslationsAppTranslationEnginesPrivateZhCn._(_root);
}

// Path: app.translation_engines_new
class _TranslationsAppTranslationEnginesNewZhCn implements TranslationsAppTranslationEnginesNewEn {
	_TranslationsAppTranslationEnginesNewZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '添加文本翻译引擎';
	@override late final _TranslationsAppTranslationEnginesNewEngineTypeZhCn engine_type = _TranslationsAppTranslationEnginesNewEngineTypeZhCn._(_root);
	@override late final _TranslationsAppTranslationEnginesNewSupportInterfaceZhCn support_interface = _TranslationsAppTranslationEnginesNewSupportInterfaceZhCn._(_root);
	@override late final _TranslationsAppTranslationEnginesNewOptionZhCn option = _TranslationsAppTranslationEnginesNewOptionZhCn._(_root);
}

// Path: app.translation_targets
class _TranslationsAppTranslationTargetsZhCn implements TranslationsAppTranslationTargetsEn {
	_TranslationsAppTranslationTargetsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppTranslationTargetsKNewZhCn kNew = _TranslationsAppTranslationTargetsKNewZhCn._(_root);
}

// Path: widget.record_shortcut_dialog
class _TranslationsWidgetRecordShortcutDialogZhCn implements TranslationsWidgetRecordShortcutDialogEn {
	_TranslationsWidgetRecordShortcutDialogZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '自定义快捷键';
}

// Path: app.ocr_engines.msg
class _TranslationsAppOcrEnginesMsgZhCn implements TranslationsAppOcrEnginesMsgEn {
	_TranslationsAppOcrEnginesMsgZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get no_available_engines => '无可用的引擎';
}

// Path: app.ocr_engines.private
class _TranslationsAppOcrEnginesPrivateZhCn implements TranslationsAppOcrEnginesPrivateEn {
	_TranslationsAppOcrEnginesPrivateZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '私有';
}

// Path: app.ocr_engines_new.engine_type
class _TranslationsAppOcrEnginesNewEngineTypeZhCn implements TranslationsAppOcrEnginesNewEngineTypeEn {
	_TranslationsAppOcrEnginesNewEngineTypeZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '引擎类型';
}

// Path: app.ocr_engines_new.option
class _TranslationsAppOcrEnginesNewOptionZhCn implements TranslationsAppOcrEnginesNewOptionEn {
	_TranslationsAppOcrEnginesNewOptionZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '选项';
}

// Path: app.settings.kLayout
class _TranslationsAppSettingsKLayoutZhCn implements TranslationsAppSettingsKLayoutEn {
	_TranslationsAppSettingsKLayoutZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppSettingsKLayoutNavgroupZhCn navgroup = _TranslationsAppSettingsKLayoutNavgroupZhCn._(_root);
}

// Path: app.settings.about
class _TranslationsAppSettingsAboutZhCn implements TranslationsAppSettingsAboutEn {
	_TranslationsAppSettingsAboutZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '关于';
	@override late final _TranslationsAppSettingsAboutPackageInfoZhCn package_info = _TranslationsAppSettingsAboutPackageInfoZhCn._(_root);
}

// Path: app.settings.advanced
class _TranslationsAppSettingsAdvancedZhCn implements TranslationsAppSettingsAdvancedEn {
	_TranslationsAppSettingsAdvancedZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '高级';
	@override late final _TranslationsAppSettingsAdvancedLaunchAtLoginZhCn launch_at_login = _TranslationsAppSettingsAdvancedLaunchAtLoginZhCn._(_root);
}

// Path: app.settings.appearance
class _TranslationsAppSettingsAppearanceZhCn implements TranslationsAppSettingsAppearanceEn {
	_TranslationsAppSettingsAppearanceZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '外观';
	@override String get subtitle => '改变你的客户端的外观。';
	@override late final _TranslationsAppSettingsAppearanceTrayIconZhCn tray_icon = _TranslationsAppSettingsAppearanceTrayIconZhCn._(_root);
	@override late final _TranslationsAppSettingsAppearanceMaxWindowHeightZhCn max_window_height = _TranslationsAppSettingsAppearanceMaxWindowHeightZhCn._(_root);
}

// Path: app.settings.changelog
class _TranslationsAppSettingsChangelogZhCn implements TranslationsAppSettingsChangelogEn {
	_TranslationsAppSettingsChangelogZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '变更日志';
	@override String get subtitle => '看看我们正在开发哪些很酷的新功能。';
}

// Path: app.settings.general
class _TranslationsAppSettingsGeneralZhCn implements TranslationsAppSettingsGeneralEn {
	_TranslationsAppSettingsGeneralZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '通用';
	@override String get subtitle => '与客户端相关的通用设置。';
	@override late final _TranslationsAppSettingsGeneralDefaultDetectTextEngineZhCn default_detect_text_engine = _TranslationsAppSettingsGeneralDefaultDetectTextEngineZhCn._(_root);
	@override late final _TranslationsAppSettingsGeneralExtractTextZhCn extract_text = _TranslationsAppSettingsGeneralExtractTextZhCn._(_root);
	@override late final _TranslationsAppSettingsGeneralDefaultTranslateEngineZhCn default_translate_engine = _TranslationsAppSettingsGeneralDefaultTranslateEngineZhCn._(_root);
	@override late final _TranslationsAppSettingsGeneralTranslationModeZhCn translation_mode = _TranslationsAppSettingsGeneralTranslationModeZhCn._(_root);
	@override late final _TranslationsAppSettingsGeneralDefaultDetectLanguageEngineZhCn default_detect_language_engine = _TranslationsAppSettingsGeneralDefaultDetectLanguageEngineZhCn._(_root);
	@override late final _TranslationsAppSettingsGeneralTranslationTargetZhCn translation_target = _TranslationsAppSettingsGeneralTranslationTargetZhCn._(_root);
	@override late final _TranslationsAppSettingsGeneralTranslateZhCn translate = _TranslationsAppSettingsGeneralTranslateZhCn._(_root);
	@override late final _TranslationsAppSettingsGeneralInputSettingsZhCn input_settings = _TranslationsAppSettingsGeneralInputSettingsZhCn._(_root);
}

// Path: app.settings.keybinds
class _TranslationsAppSettingsKeybindsZhCn implements TranslationsAppSettingsKeybindsEn {
	_TranslationsAppSettingsKeybindsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '快捷键';
	@override String get subtitle => '查看和管理客户端快捷键。';
	@override late final _TranslationsAppSettingsKeybindsWindowZhCn window = _TranslationsAppSettingsKeybindsWindowZhCn._(_root);
	@override late final _TranslationsAppSettingsKeybindsExtractTextZhCn extract_text = _TranslationsAppSettingsKeybindsExtractTextZhCn._(_root);
	@override late final _TranslationsAppSettingsKeybindsInputAssistFunctionZhCn input_assist_function = _TranslationsAppSettingsKeybindsInputAssistFunctionZhCn._(_root);
}

// Path: app.settings.language
class _TranslationsAppSettingsLanguageZhCn implements TranslationsAppSettingsLanguageEn {
	_TranslationsAppSettingsLanguageZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '语言';
}

// Path: app.settings.ocr_engines
class _TranslationsAppSettingsOcrEnginesZhCn implements TranslationsAppSettingsOcrEnginesEn {
	_TranslationsAppSettingsOcrEnginesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '文字识别';
	@override late final _TranslationsAppSettingsOcrEnginesPrivateZhCn private = _TranslationsAppSettingsOcrEnginesPrivateZhCn._(_root);
}

// Path: app.settings.translation_engines
class _TranslationsAppSettingsTranslationEnginesZhCn implements TranslationsAppSettingsTranslationEnginesEn {
	_TranslationsAppSettingsTranslationEnginesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '文本翻译';
	@override late final _TranslationsAppSettingsTranslationEnginesPrivateZhCn private = _TranslationsAppSettingsTranslationEnginesPrivateZhCn._(_root);
}

// Path: app.supported_languages.all
class _TranslationsAppSupportedLanguagesAllZhCn implements TranslationsAppSupportedLanguagesAllEn {
	_TranslationsAppSupportedLanguagesAllZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '全部';
}

// Path: app.translation_engines.msg
class _TranslationsAppTranslationEnginesMsgZhCn implements TranslationsAppTranslationEnginesMsgEn {
	_TranslationsAppTranslationEnginesMsgZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get no_available_engines => '无可用的引擎';
}

// Path: app.translation_engines.private
class _TranslationsAppTranslationEnginesPrivateZhCn implements TranslationsAppTranslationEnginesPrivateEn {
	_TranslationsAppTranslationEnginesPrivateZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '私有';
}

// Path: app.translation_engines_new.engine_type
class _TranslationsAppTranslationEnginesNewEngineTypeZhCn implements TranslationsAppTranslationEnginesNewEngineTypeEn {
	_TranslationsAppTranslationEnginesNewEngineTypeZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '引擎类型';
}

// Path: app.translation_engines_new.support_interface
class _TranslationsAppTranslationEnginesNewSupportInterfaceZhCn implements TranslationsAppTranslationEnginesNewSupportInterfaceEn {
	_TranslationsAppTranslationEnginesNewSupportInterfaceZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '支持接口';
}

// Path: app.translation_engines_new.option
class _TranslationsAppTranslationEnginesNewOptionZhCn implements TranslationsAppTranslationEnginesNewOptionEn {
	_TranslationsAppTranslationEnginesNewOptionZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '选项';
}

// Path: app.translation_targets.kNew
class _TranslationsAppTranslationTargetsKNewZhCn implements TranslationsAppTranslationTargetsKNewEn {
	_TranslationsAppTranslationTargetsKNewZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '添加翻译目标';
	@override String get title_with_edit => '编辑翻译目标';
	@override String get source_language => '源语言';
	@override String get target_language => '目标语言';
}

// Path: app.settings.kLayout.navgroup
class _TranslationsAppSettingsKLayoutNavgroupZhCn implements TranslationsAppSettingsKLayoutNavgroupEn {
	_TranslationsAppSettingsKLayoutNavgroupZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get client => '客户端';
	@override String get integrations => '服务接入';
	@override String get resources => '资源';
}

// Path: app.settings.about.package_info
class _TranslationsAppSettingsAboutPackageInfoZhCn implements TranslationsAppSettingsAboutPackageInfoEn {
	_TranslationsAppSettingsAboutPackageInfoZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get version => '版本号';
	@override String get build_number => '内部版本号';
}

// Path: app.settings.advanced.launch_at_login
class _TranslationsAppSettingsAdvancedLaunchAtLoginZhCn implements TranslationsAppSettingsAdvancedLaunchAtLoginEn {
	_TranslationsAppSettingsAdvancedLaunchAtLoginZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '开机自启动';
}

// Path: app.settings.appearance.tray_icon
class _TranslationsAppSettingsAppearanceTrayIconZhCn implements TranslationsAppSettingsAppearanceTrayIconEn {
	_TranslationsAppSettingsAppearanceTrayIconZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '托盘图标';
	@override late final _TranslationsAppSettingsAppearanceTrayIconStyleZhCn style = _TranslationsAppSettingsAppearanceTrayIconStyleZhCn._(_root);
	@override late final _TranslationsAppSettingsAppearanceTrayIconShowZhCn show = _TranslationsAppSettingsAppearanceTrayIconShowZhCn._(_root);
}

// Path: app.settings.appearance.max_window_height
class _TranslationsAppSettingsAppearanceMaxWindowHeightZhCn implements TranslationsAppSettingsAppearanceMaxWindowHeightEn {
	_TranslationsAppSettingsAppearanceMaxWindowHeightZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '最大窗口高度（逻辑像素）';
}

// Path: app.settings.general.default_detect_text_engine
class _TranslationsAppSettingsGeneralDefaultDetectTextEngineZhCn implements TranslationsAppSettingsGeneralDefaultDetectTextEngineEn {
	_TranslationsAppSettingsGeneralDefaultDetectTextEngineZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '默认文字识别引擎';
}

// Path: app.settings.general.extract_text
class _TranslationsAppSettingsGeneralExtractTextZhCn implements TranslationsAppSettingsGeneralExtractTextEn {
	_TranslationsAppSettingsGeneralExtractTextZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextZhCn auto_copy_detected_text = _TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextZhCn._(_root);
}

// Path: app.settings.general.default_translate_engine
class _TranslationsAppSettingsGeneralDefaultTranslateEngineZhCn implements TranslationsAppSettingsGeneralDefaultTranslateEngineEn {
	_TranslationsAppSettingsGeneralDefaultTranslateEngineZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '默认翻译引擎';
}

// Path: app.settings.general.translation_mode
class _TranslationsAppSettingsGeneralTranslationModeZhCn implements TranslationsAppSettingsGeneralTranslationModeEn {
	_TranslationsAppSettingsGeneralTranslationModeZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '翻译模式';
}

// Path: app.settings.general.default_detect_language_engine
class _TranslationsAppSettingsGeneralDefaultDetectLanguageEngineZhCn implements TranslationsAppSettingsGeneralDefaultDetectLanguageEngineEn {
	_TranslationsAppSettingsGeneralDefaultDetectLanguageEngineZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '默认语种识别引擎';
}

// Path: app.settings.general.translation_target
class _TranslationsAppSettingsGeneralTranslationTargetZhCn implements TranslationsAppSettingsGeneralTranslationTargetEn {
	_TranslationsAppSettingsGeneralTranslationTargetZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '翻译目标';
}

// Path: app.settings.general.translate
class _TranslationsAppSettingsGeneralTranslateZhCn implements TranslationsAppSettingsGeneralTranslateEn {
	_TranslationsAppSettingsGeneralTranslateZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultZhCn double_click_copy_result = _TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultZhCn._(_root);
}

// Path: app.settings.general.input_settings
class _TranslationsAppSettingsGeneralInputSettingsZhCn implements TranslationsAppSettingsGeneralInputSettingsEn {
	_TranslationsAppSettingsGeneralInputSettingsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '输入设置';
	@override late final _TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterZhCn submit_with_enter = _TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterZhCn._(_root);
	@override late final _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterZhCn submit_with_meta_enter = _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterZhCn._(_root);
	@override late final _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacZhCn submit_with_meta_enter_mac = _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacZhCn._(_root);
}

// Path: app.settings.keybinds.window
class _TranslationsAppSettingsKeybindsWindowZhCn implements TranslationsAppSettingsKeybindsWindowEn {
	_TranslationsAppSettingsKeybindsWindowZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppSettingsKeybindsWindowShowOrHideZhCn show_or_hide = _TranslationsAppSettingsKeybindsWindowShowOrHideZhCn._(_root);
	@override late final _TranslationsAppSettingsKeybindsWindowHideZhCn hide = _TranslationsAppSettingsKeybindsWindowHideZhCn._(_root);
}

// Path: app.settings.keybinds.extract_text
class _TranslationsAppSettingsKeybindsExtractTextZhCn implements TranslationsAppSettingsKeybindsExtractTextEn {
	_TranslationsAppSettingsKeybindsExtractTextZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '屏幕/剪切板取词';
	@override late final _TranslationsAppSettingsKeybindsExtractTextFromSelectionZhCn from_selection = _TranslationsAppSettingsKeybindsExtractTextFromSelectionZhCn._(_root);
	@override late final _TranslationsAppSettingsKeybindsExtractTextFromCaptureZhCn from_capture = _TranslationsAppSettingsKeybindsExtractTextFromCaptureZhCn._(_root);
	@override late final _TranslationsAppSettingsKeybindsExtractTextFromClipboardZhCn from_clipboard = _TranslationsAppSettingsKeybindsExtractTextFromClipboardZhCn._(_root);
}

// Path: app.settings.keybinds.input_assist_function
class _TranslationsAppSettingsKeybindsInputAssistFunctionZhCn implements TranslationsAppSettingsKeybindsInputAssistFunctionEn {
	_TranslationsAppSettingsKeybindsInputAssistFunctionZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '输入辅助功能';
	@override late final _TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentZhCn translate_input_content = _TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentZhCn._(_root);
}

// Path: app.settings.ocr_engines.private
class _TranslationsAppSettingsOcrEnginesPrivateZhCn implements TranslationsAppSettingsOcrEnginesPrivateEn {
	_TranslationsAppSettingsOcrEnginesPrivateZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '私有';
	@override String get description => '长按项目以重新排序';
}

// Path: app.settings.translation_engines.private
class _TranslationsAppSettingsTranslationEnginesPrivateZhCn implements TranslationsAppSettingsTranslationEnginesPrivateEn {
	_TranslationsAppSettingsTranslationEnginesPrivateZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '私有';
	@override String get description => '长按项目以重新排序';
}

// Path: app.settings.appearance.tray_icon.style
class _TranslationsAppSettingsAppearanceTrayIconStyleZhCn implements TranslationsAppSettingsAppearanceTrayIconStyleEn {
	_TranslationsAppSettingsAppearanceTrayIconStyleZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '托盘图标样式';
}

// Path: app.settings.appearance.tray_icon.show
class _TranslationsAppSettingsAppearanceTrayIconShowZhCn implements TranslationsAppSettingsAppearanceTrayIconShowEn {
	_TranslationsAppSettingsAppearanceTrayIconShowZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '显示托盘图标';
}

// Path: app.settings.general.extract_text.auto_copy_detected_text
class _TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextZhCn implements TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextEn {
	_TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '自动复制检测到的文本';
}

// Path: app.settings.general.translate.double_click_copy_result
class _TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultZhCn implements TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultEn {
	_TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '双击复制翻译结果';
}

// Path: app.settings.general.input_settings.submit_with_enter
class _TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterZhCn implements TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterEn {
	_TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '用 Enter 提交';
}

// Path: app.settings.general.input_settings.submit_with_meta_enter
class _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterZhCn implements TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterEn {
	_TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '用 Ctrl + Enter 提交';
}

// Path: app.settings.general.input_settings.submit_with_meta_enter_mac
class _TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacZhCn implements TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacEn {
	_TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '用 ⌘ + Enter 提交';
}

// Path: app.settings.keybinds.window.show_or_hide
class _TranslationsAppSettingsKeybindsWindowShowOrHideZhCn implements TranslationsAppSettingsKeybindsWindowShowOrHideEn {
	_TranslationsAppSettingsKeybindsWindowShowOrHideZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '显示/隐藏';
}

// Path: app.settings.keybinds.window.hide
class _TranslationsAppSettingsKeybindsWindowHideZhCn implements TranslationsAppSettingsKeybindsWindowHideEn {
	_TranslationsAppSettingsKeybindsWindowHideZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '隐藏';
}

// Path: app.settings.keybinds.extract_text.from_selection
class _TranslationsAppSettingsKeybindsExtractTextFromSelectionZhCn implements TranslationsAppSettingsKeybindsExtractTextFromSelectionEn {
	_TranslationsAppSettingsKeybindsExtractTextFromSelectionZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '选中文字';
}

// Path: app.settings.keybinds.extract_text.from_capture
class _TranslationsAppSettingsKeybindsExtractTextFromCaptureZhCn implements TranslationsAppSettingsKeybindsExtractTextFromCaptureEn {
	_TranslationsAppSettingsKeybindsExtractTextFromCaptureZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '截取区域';
}

// Path: app.settings.keybinds.extract_text.from_clipboard
class _TranslationsAppSettingsKeybindsExtractTextFromClipboardZhCn implements TranslationsAppSettingsKeybindsExtractTextFromClipboardEn {
	_TranslationsAppSettingsKeybindsExtractTextFromClipboardZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '剪切板';
}

// Path: app.settings.keybinds.input_assist_function.translate_input_content
class _TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentZhCn implements TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentEn {
	_TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '翻译当前输入框内容';
}

/// The flat map containing all translations for locale <zh-CN>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZhCn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app_name' => '比译',
			'ok' => '确定',
			'cancel' => '取消',
			'add' => '添加',
			'delete' => '删除',
			'copied' => '已复制',
			'please_choose' => '请选择',
			'language.af' => '布尔语(南非荷兰语)',
			'language.am' => '阿姆哈拉语',
			'language.ar' => '阿拉伯语',
			'language.az' => '阿塞拜疆语',
			'language.be' => '白俄罗斯语',
			'language.bg' => '保加利亚语',
			'language.bn' => '孟加拉语',
			'language.bs' => '波斯尼亚语',
			'language.ca' => '加泰罗尼亚语',
			'language.ceb' => '宿务语',
			'language.co' => '科西嘉语',
			'language.cs' => '捷克语',
			'language.cy' => '威尔士语',
			'language.da' => '丹麦语',
			'language.de' => '德语',
			'language.el' => '希腊语',
			'language.en' => '英语',
			'language.eo' => '世界语',
			'language.es' => '西班牙语',
			'language.et' => '爱沙尼亚语',
			'language.eu' => '巴斯克语',
			'language.fa' => '波斯语',
			'language.fi' => '芬兰语',
			'language.fr' => '法语',
			'language.fy' => '弗里西语',
			'language.ga' => '爱尔兰语',
			'language.gd' => '苏格兰盖尔语',
			'language.gl' => '加利西亚语',
			'language.gu' => '古吉拉特语',
			'language.ha' => '豪萨语',
			'language.haw' => '夏威夷语',
			'language.he' => '希伯来语',
			'language.hi' => '印地语',
			'language.hmn' => '苗语',
			'language.hr' => '克罗地亚语',
			'language.ht' => '海地克里奥尔语',
			'language.hu' => '匈牙利语',
			'language.hy' => '亚美尼亚语',
			'language.id' => '印尼语',
			'language.ig' => '伊博语',
			'language.kIs' => '冰岛语',
			'language.it' => '意大利语',
			'language.iw' => '希伯来语',
			'language.ja' => '日语',
			'language.jw' => '印尼爪哇语',
			'language.ka' => '格鲁吉亚语',
			'language.kk' => '哈萨克语',
			'language.km' => '高棉语',
			'language.kn' => '卡纳达语',
			'language.ko' => '韩语',
			'language.ku' => '库尔德语',
			'language.ky' => '吉尔吉斯语',
			'language.la' => '拉丁语',
			'language.lb' => '卢森堡语',
			'language.lo' => '老挝语',
			'language.lt' => '立陶宛语',
			'language.lv' => '拉脱维亚语',
			'language.mg' => '马尔加什语',
			'language.mi' => '毛利语',
			'language.mk' => '马其顿语',
			'language.ml' => '马拉雅拉姆语',
			'language.mn' => '蒙古语',
			'language.mr' => '马拉地语',
			'language.ms' => '马来语',
			'language.mt' => '马耳他语',
			'language.my' => '缅甸语',
			'language.ne' => '尼泊尔语',
			'language.nl' => '荷兰语',
			'language.no' => '挪威语',
			'language.ny' => '齐切瓦语',
			'language.or' => '奥利亚语',
			'language.pa' => '旁遮普语',
			'language.pl' => '波兰语',
			'language.ps' => '普什图语',
			'language.pt' => '葡萄牙语',
			'language.ro' => '罗马尼亚语',
			'language.ru' => '俄语',
			'language.rw' => '卢旺达语',
			'language.sd' => '信德语',
			'language.si' => '僧伽罗语',
			'language.sk' => '斯洛伐克语',
			'language.sl' => '斯洛文尼亚语',
			'language.sm' => '萨摩亚语',
			'language.sn' => '修纳语',
			'language.so' => '索马里语',
			'language.sq' => '阿尔巴尼亚语',
			'language.sr' => '塞尔维亚语',
			'language.st' => '塞索托语',
			'language.su' => '印尼巽他语',
			'language.sv' => '瑞典语',
			'language.sw' => '斯瓦希里语',
			'language.ta' => '泰米尔语',
			'language.te' => '泰卢固语',
			'language.tg' => '塔吉克语',
			'language.th' => '泰语',
			'language.tk' => '土库曼语',
			'language.tl' => '菲律宾语',
			'language.tr' => '土耳其语',
			'language.tt' => '鞑靼语',
			'language.ug' => '维吾尔语',
			'language.uk' => '乌克兰语',
			'language.ur' => '乌尔都语',
			'language.uz' => '乌兹别克语',
			'language.vi' => '越南语',
			'language.xh' => '南非科萨语',
			'language.yi' => '意第绪语',
			'language.yo' => '约鲁巴语',
			'language.zh' => '中文',
			'language.zh_CN' => '中文',
			'language.zh_TW' => '中文(繁体)',
			'language.zu' => '南非祖鲁语',
			'engine.baidu' => '百度翻译',
			'engine.caiyun' => '彩云小译',
			'engine.deepl' => 'DeepL',
			'engine.google' => '谷歌翻译',
			'engine.ibmwatson' => 'IBMWatson',
			'engine.iciba' => '爱词霸',
			'engine.openai' => 'OpenAI',
			'engine.sogou' => '搜狗翻译',
			'engine.tencent' => '腾讯翻译君',
			'engine.youdao' => '有道翻译',
			'engine_scope.detectlanguage' => '语种识别',
			'engine_scope.lookup' => '查词',
			'engine_scope.translate' => '翻译',
			'ocr_engine.built_in' => '内置',
			'ocr_engine.tesseract' => 'Tesseract OCR',
			'ocr_engine.youdao' => '有道通用文字识别',
			'translation_mode.auto' => '自动',
			'translation_mode.manual' => '手动',
			'theme_mode.light' => '浅色',
			'theme_mode.dark' => '深色',
			'theme_mode.system' => '跟随系统',
			'word_pronunciation.us' => '美',
			'word_pronunciation.uk' => '英',
			'tray_context_menu.item_show' => '显示',
			'tray_context_menu.item_quick_start_guide' => '快速入门',
			'tray_context_menu.item_discussion' => '加入讨论',
			'tray_context_menu.item_quit_app' => '退出比译',
			'tray_context_menu.item_discussion_subitem_discord_server' => '加入 Discord',
			'tray_context_menu.item_discussion_subitem_qq_group' => '加入 QQ 群',
			'app.home.newversion_banner_text_found_new_version' => ({required Object version}) => '发现新版本：${version}',
			'app.home.newversion_banner_btn_update' => '立即更新',
			'app.home.limited_banner_title' => '功能受限，请根据提示进行检查。',
			'app.home.limited_banner_text_screen_capture' => '授予屏幕录制权限',
			'app.home.limited_banner_text_screen_selection' => '授予辅助功能权限',
			'app.home.limited_banner_btn_allow' => '允许',
			'app.home.limited_banner_btn_go_settings' => '前往设置',
			'app.home.limited_banner_btn_check_again' => '重新检查',
			'app.home.limited_banner_tip_help' => '查看帮助文档',
			'app.home.limited_banner_msg_allow_access_tip' => '点击「授权」后如无任何响应，请点击「前往设置」进行手动设置。',
			'app.home.limited_banner_msg_all_access_allowed' => '屏幕取词功能已启用',
			'app.home.limited_banner_msg_all_access_not_allowed' => '未获得所需权限，\n请重新检查并进行设置。',
			'app.home.input_hint' => '在此处输入单词或文本',
			'app.home.text_extracting_text' => '正在提取文字...',
			'app.home.tip_translation_mode' => ({required Object mode}) => '当前翻译模式：${mode}',
			'app.home.tip_extract_text_from_screen_capture' => '截取屏幕区域并识别文字',
			'app.home.tip_extract_text_from_clipboard' => '读取剪切板内容',
			'app.home.btn_clear' => '清空',
			'app.home.btn_trans' => '翻译',
			'app.home.msg_please_enter_word_or_text' => '未输入或未提取到文本',
			'app.home.msg_capture_screen_area_canceled' => '截取屏幕区域已取消',
			'app.record_shortcut.title' => '录制你的快捷键',
			'app.ocr_engine_types.title' => '引擎类型',
			'app.ocr_engines.title' => '文字识别引擎',
			'app.ocr_engines.msg.no_available_engines' => '无可用的引擎',
			'app.ocr_engines.private.title' => '私有',
			'app.ocr_engines_new.title' => '添加文字识别引擎',
			'app.ocr_engines_new.engine_type.title' => '引擎类型',
			'app.ocr_engines_new.option.title' => '选项',
			'app.settings.title' => 'Settings',
			'app.settings.text_version' => ({required Object version, required Object buildNumber}) => 'Version ${version} BUILD ${buildNumber}',
			'app.settings.kLayout.navgroup.client' => '客户端',
			'app.settings.kLayout.navgroup.integrations' => '服务接入',
			'app.settings.kLayout.navgroup.resources' => '资源',
			'app.settings.about.title' => '关于',
			'app.settings.about.package_info.version' => '版本号',
			'app.settings.about.package_info.build_number' => '内部版本号',
			'app.settings.advanced.title' => '高级',
			'app.settings.advanced.launch_at_login.title' => '开机自启动',
			'app.settings.appearance.title' => '外观',
			'app.settings.appearance.subtitle' => '改变你的客户端的外观。',
			'app.settings.appearance.tray_icon.title' => '托盘图标',
			'app.settings.appearance.tray_icon.style.title' => '托盘图标样式',
			'app.settings.appearance.tray_icon.show.title' => '显示托盘图标',
			'app.settings.appearance.max_window_height.title' => '最大窗口高度（逻辑像素）',
			'app.settings.changelog.title' => '变更日志',
			'app.settings.changelog.subtitle' => '看看我们正在开发哪些很酷的新功能。',
			'app.settings.general.title' => '通用',
			'app.settings.general.subtitle' => '与客户端相关的通用设置。',
			'app.settings.general.default_detect_text_engine.title' => '默认文字识别引擎',
			'app.settings.general.extract_text.auto_copy_detected_text.title' => '自动复制检测到的文本',
			'app.settings.general.default_translate_engine.title' => '默认翻译引擎',
			'app.settings.general.translation_mode.title' => '翻译模式',
			'app.settings.general.default_detect_language_engine.title' => '默认语种识别引擎',
			'app.settings.general.translation_target.title' => '翻译目标',
			'app.settings.general.translate.double_click_copy_result.title' => '双击复制翻译结果',
			'app.settings.general.input_settings.title' => '输入设置',
			'app.settings.general.input_settings.submit_with_enter.title' => '用 Enter 提交',
			'app.settings.general.input_settings.submit_with_meta_enter.title' => '用 Ctrl + Enter 提交',
			'app.settings.general.input_settings.submit_with_meta_enter_mac.title' => '用 ⌘ + Enter 提交',
			'app.settings.keybinds.title' => '快捷键',
			'app.settings.keybinds.subtitle' => '查看和管理客户端快捷键。',
			'app.settings.keybinds.window.show_or_hide.title' => '显示/隐藏',
			'app.settings.keybinds.window.hide.title' => '隐藏',
			'app.settings.keybinds.extract_text.title' => '屏幕/剪切板取词',
			'app.settings.keybinds.extract_text.from_selection.title' => '选中文字',
			'app.settings.keybinds.extract_text.from_capture.title' => '截取区域',
			'app.settings.keybinds.extract_text.from_clipboard.title' => '剪切板',
			'app.settings.keybinds.input_assist_function.title' => '输入辅助功能',
			'app.settings.keybinds.input_assist_function.translate_input_content.title' => '翻译当前输入框内容',
			'app.settings.language.title' => '语言',
			'app.settings.ocr_engines.title' => '文字识别',
			'app.settings.ocr_engines.private.title' => '私有',
			'app.settings.ocr_engines.private.description' => '长按项目以重新排序',
			'app.settings.translation_engines.title' => '文本翻译',
			'app.settings.translation_engines.private.title' => '私有',
			'app.settings.translation_engines.private.description' => '长按项目以重新排序',
			'app.supported_languages.title' => '支持的语言',
			'app.supported_languages.all.title' => '全部',
			'app.translation_engine_types.title' => '引擎类型',
			'app.translation_engines.title' => '文本翻译引擎',
			'app.translation_engines.msg.no_available_engines' => '无可用的引擎',
			'app.translation_engines.private.title' => '私有',
			'app.translation_engines_new.title' => '添加文本翻译引擎',
			'app.translation_engines_new.engine_type.title' => '引擎类型',
			'app.translation_engines_new.support_interface.title' => '支持接口',
			'app.translation_engines_new.option.title' => '选项',
			'app.translation_targets.kNew.title' => '添加翻译目标',
			'app.translation_targets.kNew.title_with_edit' => '编辑翻译目标',
			'app.translation_targets.kNew.source_language' => '源语言',
			'app.translation_targets.kNew.target_language' => '目标语言',
			'widget.record_shortcut_dialog.title' => '自定义快捷键',
			_ => null,
		};
	}
}
