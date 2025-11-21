///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element

class Translations implements BaseTranslations<AppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final t = Translations.of(context);
  static Translations of(BuildContext context) =>
      InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  Translations(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = TranslationMetadata(
          locale: AppLocale.en,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final Translations _root = this; // ignore: unused_field

  // Translations
  String get app_name => 'Biyi';
  String get ok => 'OK';
  String get cancel => 'Cancel';
  String get add => 'Add';
  String get delete => 'Delete';
  String get copied => 'Copied';
  String get please_choose => 'Please Choose';
  late final TranslationsLanguageEn language = TranslationsLanguageEn._(_root);
  late final TranslationsEngineEn engine = TranslationsEngineEn._(_root);
  late final TranslationsEngineScopeEn engine_scope =
      TranslationsEngineScopeEn._(_root);
  late final TranslationsOcrEngineEn ocr_engine =
      TranslationsOcrEngineEn._(_root);
  late final TranslationsTranslationModeEn translation_mode =
      TranslationsTranslationModeEn._(_root);
  late final TranslationsThemeModeEn theme_mode =
      TranslationsThemeModeEn._(_root);
  late final TranslationsWordPronunciationEn word_pronunciation =
      TranslationsWordPronunciationEn._(_root);
  late final TranslationsTrayContextMenuEn tray_context_menu =
      TranslationsTrayContextMenuEn._(_root);
  late final TranslationsAppEn app = TranslationsAppEn._(_root);
  late final TranslationsWidgetEn widget = TranslationsWidgetEn._(_root);
}

// Path: language
class TranslationsLanguageEn {
  TranslationsLanguageEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get af => 'Afrikaans';
  String get am => 'Amharic';
  String get ar => 'Arabic';
  String get az => 'Azerbaijani';
  String get be => 'Belarusian';
  String get bg => 'Bulgarian';
  String get bn => 'Bengali';
  String get bs => 'Bosnian';
  String get ca => 'Catalan';
  String get ceb => 'Cebuano';
  String get co => 'Corsican';
  String get cs => 'Czech';
  String get cy => 'Welsh';
  String get da => 'Danish';
  String get de => 'German';
  String get el => 'Greek';
  String get en => 'English';
  String get eo => 'Esperanto';
  String get es => 'Spanish';
  String get et => 'Estonian';
  String get eu => 'Basque';
  String get fa => 'Persian';
  String get fi => 'Finnish';
  String get fr => 'French';
  String get fy => 'Frisian';
  String get ga => 'Irish';
  String get gd => 'Scots Gaelic';
  String get gl => 'Galician';
  String get gu => 'Gujarati';
  String get ha => 'Hausa';
  String get haw => 'Hawaiian';
  String get he => 'Hebrew';
  String get hi => 'Hindi';
  String get hmn => 'Hmong';
  String get hr => 'Croatian';
  String get ht => 'Haitian Creole';
  String get hu => 'Hungarian';
  String get hy => 'Armenian';
  String get id => 'Indonesian';
  String get ig => 'Igbo';
  String get kIs => 'Icelandic';
  String get it => 'Italian';
  String get iw => 'Hebrew';
  String get ja => 'Japanese';
  String get jw => 'Javanese';
  String get ka => 'Georgian';
  String get kk => 'Kazakh';
  String get km => 'Khmer';
  String get kn => 'Kannada';
  String get ko => 'Korean';
  String get ku => 'Kurdish (Kurmanji)';
  String get ky => 'Kyrgyz';
  String get la => 'Latin';
  String get lb => 'Luxembourgish';
  String get lo => 'Lao';
  String get lt => 'Lithuanian';
  String get lv => 'Latvian';
  String get mg => 'Malagasy';
  String get mi => 'Maori';
  String get mk => 'Macedonian';
  String get ml => 'Malayalam';
  String get mn => 'Mongolian';
  String get mr => 'Marathi';
  String get ms => 'Malay';
  String get mt => 'Maltese';
  String get my => 'Myanmar (Burmese)';
  String get ne => 'Nepali';
  String get nl => 'Dutch';
  String get no => 'Norwegian';
  String get ny => 'Chichewa';
  String get or => 'Odia (Oriya)';
  String get pa => 'Punjabi';
  String get pl => 'Polish';
  String get ps => 'Pashto';
  String get pt => 'Portuguese';
  String get ro => 'Romanian';
  String get ru => 'Russian';
  String get rw => 'Kinyarwanda';
  String get sd => 'Sindhi';
  String get si => 'Sinhala';
  String get sk => 'Slovak';
  String get sl => 'Slovenian';
  String get sm => 'Samoan';
  String get sn => 'Shona';
  String get so => 'Somali';
  String get sq => 'Albanian';
  String get sr => 'Serbian';
  String get st => 'Sesotho';
  String get su => 'Sundanese';
  String get sv => 'Swedish';
  String get sw => 'Swahili';
  String get ta => 'Tamil';
  String get te => 'Telugu';
  String get tg => 'Tajik';
  String get th => 'Thai';
  String get tk => 'Turkmen';
  String get tl => 'Filipino';
  String get tr => 'Turkish';
  String get tt => 'Tatar';
  String get ug => 'Uyghur';
  String get uk => 'Ukrainian';
  String get ur => 'Urdu';
  String get uz => 'Uzbek';
  String get vi => 'Vietnamese';
  String get xh => 'Xhosa';
  String get yi => 'Yiddish';
  String get yo => 'Yoruba';
  String get zh => 'Chinese';
  String get zh_CN => 'Chinese';
  String get zh_TW => 'Chinese (Traditional)';
  String get zu => 'Zulu';
}

// Path: engine
class TranslationsEngineEn {
  TranslationsEngineEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get baidu => 'Baidu';
  String get caiyun => 'Caiyun';
  String get deepl => 'DeepL';
  String get google => 'Google';
  String get ibmwatson => 'IBMWatson';
  String get iciba => 'Iciba';
  String get openai => 'OpenAI';
  String get sogou => 'Sogou';
  String get tencent => 'Tencent';
  String get youdao => 'Youda';
}

// Path: engine_scope
class TranslationsEngineScopeEn {
  TranslationsEngineScopeEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get detectlanguage => 'detectLanguage';
  String get lookup => 'LookUp';
  String get translate => 'Translate';
}

// Path: ocr_engine
class TranslationsOcrEngineEn {
  TranslationsOcrEngineEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get built_in => 'Built In';
  String get tesseract => 'Tesseract OCR';
  String get youdao => 'Youdao';
}

// Path: translation_mode
class TranslationsTranslationModeEn {
  TranslationsTranslationModeEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get auto => 'Auto';
  String get manual => 'Manual';
}

// Path: theme_mode
class TranslationsThemeModeEn {
  TranslationsThemeModeEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get light => 'Light';
  String get dark => 'Dark';
  String get system => 'System';
}

// Path: word_pronunciation
class TranslationsWordPronunciationEn {
  TranslationsWordPronunciationEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get us => 'US';
  String get uk => 'UK';
}

// Path: tray_context_menu
class TranslationsTrayContextMenuEn {
  TranslationsTrayContextMenuEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get item_show => 'Show';
  String get item_quick_start_guide => 'Quick Start';
  String get item_discussion => 'Join Discussion';
  String get item_quit_app => 'Quit Biyi';
  String get item_discussion_subitem_discord_server => 'Join Discord';
  String get item_discussion_subitem_qq_group => 'Join QQ Group';
}

// Path: app
class TranslationsAppEn {
  TranslationsAppEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsAppHomeEn home = TranslationsAppHomeEn._(_root);
  late final TranslationsAppRecordShortcutEn record_shortcut =
      TranslationsAppRecordShortcutEn._(_root);
  late final TranslationsAppOcrEngineTypesEn ocr_engine_types =
      TranslationsAppOcrEngineTypesEn._(_root);
  late final TranslationsAppOcrEnginesEn ocr_engines =
      TranslationsAppOcrEnginesEn._(_root);
  late final TranslationsAppOcrEnginesNewEn ocr_engines_new =
      TranslationsAppOcrEnginesNewEn._(_root);
  late final TranslationsAppSettingsEn settings =
      TranslationsAppSettingsEn._(_root);
  late final TranslationsAppSupportedLanguagesEn supported_languages =
      TranslationsAppSupportedLanguagesEn._(_root);
  late final TranslationsAppTranslationEngineTypesEn translation_engine_types =
      TranslationsAppTranslationEngineTypesEn._(_root);
  late final TranslationsAppTranslationEnginesEn translation_engines =
      TranslationsAppTranslationEnginesEn._(_root);
  late final TranslationsAppTranslationEnginesNewEn translation_engines_new =
      TranslationsAppTranslationEnginesNewEn._(_root);
  late final TranslationsAppTranslationTargetsEn translation_targets =
      TranslationsAppTranslationTargetsEn._(_root);
}

// Path: widget
class TranslationsWidgetEn {
  TranslationsWidgetEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsWidgetRecordShortcutDialogEn record_shortcut_dialog =
      TranslationsWidgetRecordShortcutDialogEn._(_root);
}

// Path: app.home
class TranslationsAppHomeEn {
  TranslationsAppHomeEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String newversion_banner_text_found_new_version({required Object version}) =>
      'New version found: ${version}';
  String get newversion_banner_btn_update => 'Update';
  String get limited_banner_title =>
      'Functionality is limited, please perform a check according to the prompts.';
  String get limited_banner_text_screen_capture =>
      'Grant screen recording access';
  String get limited_banner_text_screen_selection =>
      'Grant accessibility access';
  String get limited_banner_btn_allow => 'Allow';
  String get limited_banner_btn_go_settings => 'Go Settings';
  String get limited_banner_btn_check_again => 'Check Again';
  String get limited_banner_tip_help => 'View the help document';
  String get limited_banner_msg_allow_access_tip =>
      'If there is no response after clicking "Allow", please click "Go Settings" to set it manually.';
  String get limited_banner_msg_all_access_allowed =>
      'The Screen extract text is enabled';
  String get limited_banner_msg_all_access_not_allowed =>
      'The required access are not allowed.\nPlease check and set again.';
  String get input_hint => 'Enter the word or text here';
  String get text_extracting_text => 'Extracting text...';
  String tip_translation_mode({required Object mode}) =>
      'Current translation mode: ${mode}';
  String get tip_extract_text_from_screen_capture =>
      'Capture screen area and recognize text';
  String get tip_extract_text_from_clipboard => 'Read clipboard content';
  String get btn_clear => 'Clear';
  String get btn_trans => 'Translate';
  String get msg_please_enter_word_or_text =>
      'No text entered or text not extracted';
  String get msg_capture_screen_area_canceled =>
      'Capture screen area has been canceled';
}

// Path: app.record_shortcut
class TranslationsAppRecordShortcutEn {
  TranslationsAppRecordShortcutEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Record your shortcut';
}

// Path: app.ocr_engine_types
class TranslationsAppOcrEngineTypesEn {
  TranslationsAppOcrEngineTypesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Engine Type';
}

// Path: app.ocr_engines
class TranslationsAppOcrEnginesEn {
  TranslationsAppOcrEnginesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Text Detections Engines';
  late final TranslationsAppOcrEnginesMsgEn msg =
      TranslationsAppOcrEnginesMsgEn._(_root);
  late final TranslationsAppOcrEnginesPrivateEn private =
      TranslationsAppOcrEnginesPrivateEn._(_root);
}

// Path: app.ocr_engines_new
class TranslationsAppOcrEnginesNewEn {
  TranslationsAppOcrEnginesNewEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Add Text Detection Engine';
  late final TranslationsAppOcrEnginesNewEngineTypeEn engine_type =
      TranslationsAppOcrEnginesNewEngineTypeEn._(_root);
  late final TranslationsAppOcrEnginesNewOptionEn option =
      TranslationsAppOcrEnginesNewOptionEn._(_root);
}

// Path: app.settings
class TranslationsAppSettingsEn {
  TranslationsAppSettingsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Settings';
  String text_version({required Object version, required Object buildNumber}) =>
      'Version ${version} BUILD ${buildNumber}';
  late final TranslationsAppSettingsKLayoutEn kLayout =
      TranslationsAppSettingsKLayoutEn._(_root);
  late final TranslationsAppSettingsAboutEn about =
      TranslationsAppSettingsAboutEn._(_root);
  late final TranslationsAppSettingsAdvancedEn advanced =
      TranslationsAppSettingsAdvancedEn._(_root);
  late final TranslationsAppSettingsAppearanceEn appearance =
      TranslationsAppSettingsAppearanceEn._(_root);
  late final TranslationsAppSettingsChangelogEn changelog =
      TranslationsAppSettingsChangelogEn._(_root);
  late final TranslationsAppSettingsGeneralEn general =
      TranslationsAppSettingsGeneralEn._(_root);
  late final TranslationsAppSettingsKeybindsEn keybinds =
      TranslationsAppSettingsKeybindsEn._(_root);
  late final TranslationsAppSettingsLanguageEn language =
      TranslationsAppSettingsLanguageEn._(_root);
  late final TranslationsAppSettingsOcrEnginesEn ocr_engines =
      TranslationsAppSettingsOcrEnginesEn._(_root);
  late final TranslationsAppSettingsTranslationEnginesEn translation_engines =
      TranslationsAppSettingsTranslationEnginesEn._(_root);
}

// Path: app.supported_languages
class TranslationsAppSupportedLanguagesEn {
  TranslationsAppSupportedLanguagesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Supported Languages';
  late final TranslationsAppSupportedLanguagesAllEn all =
      TranslationsAppSupportedLanguagesAllEn._(_root);
}

// Path: app.translation_engine_types
class TranslationsAppTranslationEngineTypesEn {
  TranslationsAppTranslationEngineTypesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Engine Type';
}

// Path: app.translation_engines
class TranslationsAppTranslationEnginesEn {
  TranslationsAppTranslationEnginesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Text Translation Engines';
  late final TranslationsAppTranslationEnginesMsgEn msg =
      TranslationsAppTranslationEnginesMsgEn._(_root);
  late final TranslationsAppTranslationEnginesPrivateEn private =
      TranslationsAppTranslationEnginesPrivateEn._(_root);
}

// Path: app.translation_engines_new
class TranslationsAppTranslationEnginesNewEn {
  TranslationsAppTranslationEnginesNewEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Add Text Translation Engine';
  late final TranslationsAppTranslationEnginesNewEngineTypeEn engine_type =
      TranslationsAppTranslationEnginesNewEngineTypeEn._(_root);
  late final TranslationsAppTranslationEnginesNewSupportInterfaceEn
      support_interface =
      TranslationsAppTranslationEnginesNewSupportInterfaceEn._(_root);
  late final TranslationsAppTranslationEnginesNewOptionEn option =
      TranslationsAppTranslationEnginesNewOptionEn._(_root);
}

// Path: app.translation_targets
class TranslationsAppTranslationTargetsEn {
  TranslationsAppTranslationTargetsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsAppTranslationTargetsKNewEn kNew =
      TranslationsAppTranslationTargetsKNewEn._(_root);
}

// Path: widget.record_shortcut_dialog
class TranslationsWidgetRecordShortcutDialogEn {
  TranslationsWidgetRecordShortcutDialogEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Customize your shortcut';
}

// Path: app.ocr_engines.msg
class TranslationsAppOcrEnginesMsgEn {
  TranslationsAppOcrEnginesMsgEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get no_available_engines => 'No available engines';
}

// Path: app.ocr_engines.private
class TranslationsAppOcrEnginesPrivateEn {
  TranslationsAppOcrEnginesPrivateEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Private';
}

// Path: app.ocr_engines_new.engine_type
class TranslationsAppOcrEnginesNewEngineTypeEn {
  TranslationsAppOcrEnginesNewEngineTypeEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Engine type';
}

// Path: app.ocr_engines_new.option
class TranslationsAppOcrEnginesNewOptionEn {
  TranslationsAppOcrEnginesNewOptionEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Option';
}

// Path: app.settings.kLayout
class TranslationsAppSettingsKLayoutEn {
  TranslationsAppSettingsKLayoutEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsAppSettingsKLayoutNavgroupEn navgroup =
      TranslationsAppSettingsKLayoutNavgroupEn._(_root);
}

// Path: app.settings.about
class TranslationsAppSettingsAboutEn {
  TranslationsAppSettingsAboutEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'About';
  late final TranslationsAppSettingsAboutPackageInfoEn package_info =
      TranslationsAppSettingsAboutPackageInfoEn._(_root);
}

// Path: app.settings.advanced
class TranslationsAppSettingsAdvancedEn {
  TranslationsAppSettingsAdvancedEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Advanced';
  late final TranslationsAppSettingsAdvancedLaunchAtLoginEn launch_at_login =
      TranslationsAppSettingsAdvancedLaunchAtLoginEn._(_root);
}

// Path: app.settings.appearance
class TranslationsAppSettingsAppearanceEn {
  TranslationsAppSettingsAppearanceEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Appearance';
  String get subtitle => 'Change the look of your client.';
  late final TranslationsAppSettingsAppearanceTrayIconEn tray_icon =
      TranslationsAppSettingsAppearanceTrayIconEn._(_root);
  late final TranslationsAppSettingsAppearanceMaxWindowHeightEn
      max_window_height =
      TranslationsAppSettingsAppearanceMaxWindowHeightEn._(_root);
}

// Path: app.settings.changelog
class TranslationsAppSettingsChangelogEn {
  TranslationsAppSettingsChangelogEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Changelog';
  String get subtitle => 'See what cool new features we\'re making.';
}

// Path: app.settings.general
class TranslationsAppSettingsGeneralEn {
  TranslationsAppSettingsGeneralEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'General';
  String get subtitle => 'General settings related to the client.';
  late final TranslationsAppSettingsGeneralDefaultDetectTextEngineEn
      default_detect_text_engine =
      TranslationsAppSettingsGeneralDefaultDetectTextEngineEn._(_root);
  late final TranslationsAppSettingsGeneralExtractTextEn extract_text =
      TranslationsAppSettingsGeneralExtractTextEn._(_root);
  late final TranslationsAppSettingsGeneralDefaultTranslateEngineEn
      default_translate_engine =
      TranslationsAppSettingsGeneralDefaultTranslateEngineEn._(_root);
  late final TranslationsAppSettingsGeneralTranslationModeEn translation_mode =
      TranslationsAppSettingsGeneralTranslationModeEn._(_root);
  late final TranslationsAppSettingsGeneralDefaultDetectLanguageEngineEn
      default_detect_language_engine =
      TranslationsAppSettingsGeneralDefaultDetectLanguageEngineEn._(_root);
  late final TranslationsAppSettingsGeneralTranslationTargetEn
      translation_target =
      TranslationsAppSettingsGeneralTranslationTargetEn._(_root);
  late final TranslationsAppSettingsGeneralTranslateEn translate =
      TranslationsAppSettingsGeneralTranslateEn._(_root);
  late final TranslationsAppSettingsGeneralInputSettingsEn input_settings =
      TranslationsAppSettingsGeneralInputSettingsEn._(_root);
}

// Path: app.settings.keybinds
class TranslationsAppSettingsKeybindsEn {
  TranslationsAppSettingsKeybindsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Keybinds';
  String get subtitle => 'View and manage client keybinds';
  late final TranslationsAppSettingsKeybindsWindowEn window =
      TranslationsAppSettingsKeybindsWindowEn._(_root);
  late final TranslationsAppSettingsKeybindsExtractTextEn extract_text =
      TranslationsAppSettingsKeybindsExtractTextEn._(_root);
  late final TranslationsAppSettingsKeybindsInputAssistFunctionEn
      input_assist_function =
      TranslationsAppSettingsKeybindsInputAssistFunctionEn._(_root);
}

// Path: app.settings.language
class TranslationsAppSettingsLanguageEn {
  TranslationsAppSettingsLanguageEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Language';
}

// Path: app.settings.ocr_engines
class TranslationsAppSettingsOcrEnginesEn {
  TranslationsAppSettingsOcrEnginesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Text Detections';
  late final TranslationsAppSettingsOcrEnginesPrivateEn private =
      TranslationsAppSettingsOcrEnginesPrivateEn._(_root);
}

// Path: app.settings.translation_engines
class TranslationsAppSettingsTranslationEnginesEn {
  TranslationsAppSettingsTranslationEnginesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Text Translations';
  late final TranslationsAppSettingsTranslationEnginesPrivateEn private =
      TranslationsAppSettingsTranslationEnginesPrivateEn._(_root);
}

// Path: app.supported_languages.all
class TranslationsAppSupportedLanguagesAllEn {
  TranslationsAppSupportedLanguagesAllEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'All';
}

// Path: app.translation_engines.msg
class TranslationsAppTranslationEnginesMsgEn {
  TranslationsAppTranslationEnginesMsgEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get no_available_engines => 'No available engines';
}

// Path: app.translation_engines.private
class TranslationsAppTranslationEnginesPrivateEn {
  TranslationsAppTranslationEnginesPrivateEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Private';
}

// Path: app.translation_engines_new.engine_type
class TranslationsAppTranslationEnginesNewEngineTypeEn {
  TranslationsAppTranslationEnginesNewEngineTypeEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Engine type';
}

// Path: app.translation_engines_new.support_interface
class TranslationsAppTranslationEnginesNewSupportInterfaceEn {
  TranslationsAppTranslationEnginesNewSupportInterfaceEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Support interface';
}

// Path: app.translation_engines_new.option
class TranslationsAppTranslationEnginesNewOptionEn {
  TranslationsAppTranslationEnginesNewOptionEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Option';
}

// Path: app.translation_targets.kNew
class TranslationsAppTranslationTargetsKNewEn {
  TranslationsAppTranslationTargetsKNewEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Add Translation Target';
  String get title_with_edit => 'Edit Translation Target';
  String get source_language => 'Source language';
  String get target_language => 'Target language';
}

// Path: app.settings.kLayout.navgroup
class TranslationsAppSettingsKLayoutNavgroupEn {
  TranslationsAppSettingsKLayoutNavgroupEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get client => 'Client';
  String get integrations => 'Integrations';
  String get resources => 'Resources';
}

// Path: app.settings.about.package_info
class TranslationsAppSettingsAboutPackageInfoEn {
  TranslationsAppSettingsAboutPackageInfoEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get version => 'Version';
  String get build_number => 'Build Number';
}

// Path: app.settings.advanced.launch_at_login
class TranslationsAppSettingsAdvancedLaunchAtLoginEn {
  TranslationsAppSettingsAdvancedLaunchAtLoginEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Launch at login';
}

// Path: app.settings.appearance.tray_icon
class TranslationsAppSettingsAppearanceTrayIconEn {
  TranslationsAppSettingsAppearanceTrayIconEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Tray Icon';
  late final TranslationsAppSettingsAppearanceTrayIconStyleEn style =
      TranslationsAppSettingsAppearanceTrayIconStyleEn._(_root);
  late final TranslationsAppSettingsAppearanceTrayIconShowEn show =
      TranslationsAppSettingsAppearanceTrayIconShowEn._(_root);
}

// Path: app.settings.appearance.max_window_height
class TranslationsAppSettingsAppearanceMaxWindowHeightEn {
  TranslationsAppSettingsAppearanceMaxWindowHeightEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Maximum window height (logical pixels)';
}

// Path: app.settings.general.default_detect_text_engine
class TranslationsAppSettingsGeneralDefaultDetectTextEngineEn {
  TranslationsAppSettingsGeneralDefaultDetectTextEngineEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Default detect text engine';
}

// Path: app.settings.general.extract_text
class TranslationsAppSettingsGeneralExtractTextEn {
  TranslationsAppSettingsGeneralExtractTextEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextEn
      auto_copy_detected_text =
      TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextEn._(_root);
}

// Path: app.settings.general.default_translate_engine
class TranslationsAppSettingsGeneralDefaultTranslateEngineEn {
  TranslationsAppSettingsGeneralDefaultTranslateEngineEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Default translate engine';
}

// Path: app.settings.general.translation_mode
class TranslationsAppSettingsGeneralTranslationModeEn {
  TranslationsAppSettingsGeneralTranslationModeEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Translation Mode';
}

// Path: app.settings.general.default_detect_language_engine
class TranslationsAppSettingsGeneralDefaultDetectLanguageEngineEn {
  TranslationsAppSettingsGeneralDefaultDetectLanguageEngineEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Default detect language engine';
}

// Path: app.settings.general.translation_target
class TranslationsAppSettingsGeneralTranslationTargetEn {
  TranslationsAppSettingsGeneralTranslationTargetEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Translation target';
}

// Path: app.settings.general.translate
class TranslationsAppSettingsGeneralTranslateEn {
  TranslationsAppSettingsGeneralTranslateEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultEn
      double_click_copy_result =
      TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultEn._(_root);
}

// Path: app.settings.general.input_settings
class TranslationsAppSettingsGeneralInputSettingsEn {
  TranslationsAppSettingsGeneralInputSettingsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Input Settings';
  late final TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterEn
      submit_with_enter =
      TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterEn._(_root);
  late final TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterEn
      submit_with_meta_enter =
      TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterEn._(_root);
  late final TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacEn
      submit_with_meta_enter_mac =
      TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacEn._(
          _root);
}

// Path: app.settings.keybinds.window
class TranslationsAppSettingsKeybindsWindowEn {
  TranslationsAppSettingsKeybindsWindowEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsAppSettingsKeybindsWindowShowOrHideEn show_or_hide =
      TranslationsAppSettingsKeybindsWindowShowOrHideEn._(_root);
  late final TranslationsAppSettingsKeybindsWindowHideEn hide =
      TranslationsAppSettingsKeybindsWindowHideEn._(_root);
}

// Path: app.settings.keybinds.extract_text
class TranslationsAppSettingsKeybindsExtractTextEn {
  TranslationsAppSettingsKeybindsExtractTextEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Screen / Clipboard extract text';
  late final TranslationsAppSettingsKeybindsExtractTextFromSelectionEn
      from_selection =
      TranslationsAppSettingsKeybindsExtractTextFromSelectionEn._(_root);
  late final TranslationsAppSettingsKeybindsExtractTextFromCaptureEn
      from_capture =
      TranslationsAppSettingsKeybindsExtractTextFromCaptureEn._(_root);
  late final TranslationsAppSettingsKeybindsExtractTextFromClipboardEn
      from_clipboard =
      TranslationsAppSettingsKeybindsExtractTextFromClipboardEn._(_root);
}

// Path: app.settings.keybinds.input_assist_function
class TranslationsAppSettingsKeybindsInputAssistFunctionEn {
  TranslationsAppSettingsKeybindsInputAssistFunctionEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Input assist function';
  late final TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentEn
      translate_input_content =
      TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentEn
          ._(_root);
}

// Path: app.settings.ocr_engines.private
class TranslationsAppSettingsOcrEnginesPrivateEn {
  TranslationsAppSettingsOcrEnginesPrivateEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Private';
  String get description => 'Long press an item to reorder it';
}

// Path: app.settings.translation_engines.private
class TranslationsAppSettingsTranslationEnginesPrivateEn {
  TranslationsAppSettingsTranslationEnginesPrivateEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Private';
  String get description => 'Long press an item to reorder it';
}

// Path: app.settings.appearance.tray_icon.style
class TranslationsAppSettingsAppearanceTrayIconStyleEn {
  TranslationsAppSettingsAppearanceTrayIconStyleEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Tray Icon Style';
}

// Path: app.settings.appearance.tray_icon.show
class TranslationsAppSettingsAppearanceTrayIconShowEn {
  TranslationsAppSettingsAppearanceTrayIconShowEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Show Tray Icon';
}

// Path: app.settings.general.extract_text.auto_copy_detected_text
class TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextEn {
  TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Auto copy the detected text';
}

// Path: app.settings.general.translate.double_click_copy_result
class TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultEn {
  TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Double-click to copy translation result';
}

// Path: app.settings.general.input_settings.submit_with_enter
class TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterEn {
  TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Submit with Enter';
}

// Path: app.settings.general.input_settings.submit_with_meta_enter
class TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterEn {
  TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterEn._(
      this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Submit with Ctrl + Enter';
}

// Path: app.settings.general.input_settings.submit_with_meta_enter_mac
class TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacEn {
  TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacEn._(
      this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Submit with ⌘ + Enter';
}

// Path: app.settings.keybinds.window.show_or_hide
class TranslationsAppSettingsKeybindsWindowShowOrHideEn {
  TranslationsAppSettingsKeybindsWindowShowOrHideEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Show/Hide';
}

// Path: app.settings.keybinds.window.hide
class TranslationsAppSettingsKeybindsWindowHideEn {
  TranslationsAppSettingsKeybindsWindowHideEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Hide';
}

// Path: app.settings.keybinds.extract_text.from_selection
class TranslationsAppSettingsKeybindsExtractTextFromSelectionEn {
  TranslationsAppSettingsKeybindsExtractTextFromSelectionEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Selection';
}

// Path: app.settings.keybinds.extract_text.from_capture
class TranslationsAppSettingsKeybindsExtractTextFromCaptureEn {
  TranslationsAppSettingsKeybindsExtractTextFromCaptureEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Capture Area';
}

// Path: app.settings.keybinds.extract_text.from_clipboard
class TranslationsAppSettingsKeybindsExtractTextFromClipboardEn {
  TranslationsAppSettingsKeybindsExtractTextFromClipboardEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Clipboard';
}

// Path: app.settings.keybinds.input_assist_function.translate_input_content
class TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentEn {
  TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentEn._(
      this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Translate input content';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'app_name':
        return 'Biyi';
      case 'ok':
        return 'OK';
      case 'cancel':
        return 'Cancel';
      case 'add':
        return 'Add';
      case 'delete':
        return 'Delete';
      case 'copied':
        return 'Copied';
      case 'please_choose':
        return 'Please Choose';
      case 'language.af':
        return 'Afrikaans';
      case 'language.am':
        return 'Amharic';
      case 'language.ar':
        return 'Arabic';
      case 'language.az':
        return 'Azerbaijani';
      case 'language.be':
        return 'Belarusian';
      case 'language.bg':
        return 'Bulgarian';
      case 'language.bn':
        return 'Bengali';
      case 'language.bs':
        return 'Bosnian';
      case 'language.ca':
        return 'Catalan';
      case 'language.ceb':
        return 'Cebuano';
      case 'language.co':
        return 'Corsican';
      case 'language.cs':
        return 'Czech';
      case 'language.cy':
        return 'Welsh';
      case 'language.da':
        return 'Danish';
      case 'language.de':
        return 'German';
      case 'language.el':
        return 'Greek';
      case 'language.en':
        return 'English';
      case 'language.eo':
        return 'Esperanto';
      case 'language.es':
        return 'Spanish';
      case 'language.et':
        return 'Estonian';
      case 'language.eu':
        return 'Basque';
      case 'language.fa':
        return 'Persian';
      case 'language.fi':
        return 'Finnish';
      case 'language.fr':
        return 'French';
      case 'language.fy':
        return 'Frisian';
      case 'language.ga':
        return 'Irish';
      case 'language.gd':
        return 'Scots Gaelic';
      case 'language.gl':
        return 'Galician';
      case 'language.gu':
        return 'Gujarati';
      case 'language.ha':
        return 'Hausa';
      case 'language.haw':
        return 'Hawaiian';
      case 'language.he':
        return 'Hebrew';
      case 'language.hi':
        return 'Hindi';
      case 'language.hmn':
        return 'Hmong';
      case 'language.hr':
        return 'Croatian';
      case 'language.ht':
        return 'Haitian Creole';
      case 'language.hu':
        return 'Hungarian';
      case 'language.hy':
        return 'Armenian';
      case 'language.id':
        return 'Indonesian';
      case 'language.ig':
        return 'Igbo';
      case 'language.kIs':
        return 'Icelandic';
      case 'language.it':
        return 'Italian';
      case 'language.iw':
        return 'Hebrew';
      case 'language.ja':
        return 'Japanese';
      case 'language.jw':
        return 'Javanese';
      case 'language.ka':
        return 'Georgian';
      case 'language.kk':
        return 'Kazakh';
      case 'language.km':
        return 'Khmer';
      case 'language.kn':
        return 'Kannada';
      case 'language.ko':
        return 'Korean';
      case 'language.ku':
        return 'Kurdish (Kurmanji)';
      case 'language.ky':
        return 'Kyrgyz';
      case 'language.la':
        return 'Latin';
      case 'language.lb':
        return 'Luxembourgish';
      case 'language.lo':
        return 'Lao';
      case 'language.lt':
        return 'Lithuanian';
      case 'language.lv':
        return 'Latvian';
      case 'language.mg':
        return 'Malagasy';
      case 'language.mi':
        return 'Maori';
      case 'language.mk':
        return 'Macedonian';
      case 'language.ml':
        return 'Malayalam';
      case 'language.mn':
        return 'Mongolian';
      case 'language.mr':
        return 'Marathi';
      case 'language.ms':
        return 'Malay';
      case 'language.mt':
        return 'Maltese';
      case 'language.my':
        return 'Myanmar (Burmese)';
      case 'language.ne':
        return 'Nepali';
      case 'language.nl':
        return 'Dutch';
      case 'language.no':
        return 'Norwegian';
      case 'language.ny':
        return 'Chichewa';
      case 'language.or':
        return 'Odia (Oriya)';
      case 'language.pa':
        return 'Punjabi';
      case 'language.pl':
        return 'Polish';
      case 'language.ps':
        return 'Pashto';
      case 'language.pt':
        return 'Portuguese';
      case 'language.ro':
        return 'Romanian';
      case 'language.ru':
        return 'Russian';
      case 'language.rw':
        return 'Kinyarwanda';
      case 'language.sd':
        return 'Sindhi';
      case 'language.si':
        return 'Sinhala';
      case 'language.sk':
        return 'Slovak';
      case 'language.sl':
        return 'Slovenian';
      case 'language.sm':
        return 'Samoan';
      case 'language.sn':
        return 'Shona';
      case 'language.so':
        return 'Somali';
      case 'language.sq':
        return 'Albanian';
      case 'language.sr':
        return 'Serbian';
      case 'language.st':
        return 'Sesotho';
      case 'language.su':
        return 'Sundanese';
      case 'language.sv':
        return 'Swedish';
      case 'language.sw':
        return 'Swahili';
      case 'language.ta':
        return 'Tamil';
      case 'language.te':
        return 'Telugu';
      case 'language.tg':
        return 'Tajik';
      case 'language.th':
        return 'Thai';
      case 'language.tk':
        return 'Turkmen';
      case 'language.tl':
        return 'Filipino';
      case 'language.tr':
        return 'Turkish';
      case 'language.tt':
        return 'Tatar';
      case 'language.ug':
        return 'Uyghur';
      case 'language.uk':
        return 'Ukrainian';
      case 'language.ur':
        return 'Urdu';
      case 'language.uz':
        return 'Uzbek';
      case 'language.vi':
        return 'Vietnamese';
      case 'language.xh':
        return 'Xhosa';
      case 'language.yi':
        return 'Yiddish';
      case 'language.yo':
        return 'Yoruba';
      case 'language.zh':
        return 'Chinese';
      case 'language.zh_CN':
        return 'Chinese';
      case 'language.zh_TW':
        return 'Chinese (Traditional)';
      case 'language.zu':
        return 'Zulu';
      case 'engine.baidu':
        return 'Baidu';
      case 'engine.caiyun':
        return 'Caiyun';
      case 'engine.deepl':
        return 'DeepL';
      case 'engine.google':
        return 'Google';
      case 'engine.ibmwatson':
        return 'IBMWatson';
      case 'engine.iciba':
        return 'Iciba';
      case 'engine.openai':
        return 'OpenAI';
      case 'engine.sogou':
        return 'Sogou';
      case 'engine.tencent':
        return 'Tencent';
      case 'engine.youdao':
        return 'Youda';
      case 'engine_scope.detectlanguage':
        return 'detectLanguage';
      case 'engine_scope.lookup':
        return 'LookUp';
      case 'engine_scope.translate':
        return 'Translate';
      case 'ocr_engine.built_in':
        return 'Built In';
      case 'ocr_engine.tesseract':
        return 'Tesseract OCR';
      case 'ocr_engine.youdao':
        return 'Youdao';
      case 'translation_mode.auto':
        return 'Auto';
      case 'translation_mode.manual':
        return 'Manual';
      case 'theme_mode.light':
        return 'Light';
      case 'theme_mode.dark':
        return 'Dark';
      case 'theme_mode.system':
        return 'System';
      case 'word_pronunciation.us':
        return 'US';
      case 'word_pronunciation.uk':
        return 'UK';
      case 'tray_context_menu.item_show':
        return 'Show';
      case 'tray_context_menu.item_quick_start_guide':
        return 'Quick Start';
      case 'tray_context_menu.item_discussion':
        return 'Join Discussion';
      case 'tray_context_menu.item_quit_app':
        return 'Quit Biyi';
      case 'tray_context_menu.item_discussion_subitem_discord_server':
        return 'Join Discord';
      case 'tray_context_menu.item_discussion_subitem_qq_group':
        return 'Join QQ Group';
      case 'app.home.newversion_banner_text_found_new_version':
        return ({required Object version}) => 'New version found: ${version}';
      case 'app.home.newversion_banner_btn_update':
        return 'Update';
      case 'app.home.limited_banner_title':
        return 'Functionality is limited, please perform a check according to the prompts.';
      case 'app.home.limited_banner_text_screen_capture':
        return 'Grant screen recording access';
      case 'app.home.limited_banner_text_screen_selection':
        return 'Grant accessibility access';
      case 'app.home.limited_banner_btn_allow':
        return 'Allow';
      case 'app.home.limited_banner_btn_go_settings':
        return 'Go Settings';
      case 'app.home.limited_banner_btn_check_again':
        return 'Check Again';
      case 'app.home.limited_banner_tip_help':
        return 'View the help document';
      case 'app.home.limited_banner_msg_allow_access_tip':
        return 'If there is no response after clicking "Allow", please click "Go Settings" to set it manually.';
      case 'app.home.limited_banner_msg_all_access_allowed':
        return 'The Screen extract text is enabled';
      case 'app.home.limited_banner_msg_all_access_not_allowed':
        return 'The required access are not allowed.\nPlease check and set again.';
      case 'app.home.input_hint':
        return 'Enter the word or text here';
      case 'app.home.text_extracting_text':
        return 'Extracting text...';
      case 'app.home.tip_translation_mode':
        return ({required Object mode}) => 'Current translation mode: ${mode}';
      case 'app.home.tip_extract_text_from_screen_capture':
        return 'Capture screen area and recognize text';
      case 'app.home.tip_extract_text_from_clipboard':
        return 'Read clipboard content';
      case 'app.home.btn_clear':
        return 'Clear';
      case 'app.home.btn_trans':
        return 'Translate';
      case 'app.home.msg_please_enter_word_or_text':
        return 'No text entered or text not extracted';
      case 'app.home.msg_capture_screen_area_canceled':
        return 'Capture screen area has been canceled';
      case 'app.record_shortcut.title':
        return 'Record your shortcut';
      case 'app.ocr_engine_types.title':
        return 'Engine Type';
      case 'app.ocr_engines.title':
        return 'Text Detections Engines';
      case 'app.ocr_engines.msg.no_available_engines':
        return 'No available engines';
      case 'app.ocr_engines.private.title':
        return 'Private';
      case 'app.ocr_engines_new.title':
        return 'Add Text Detection Engine';
      case 'app.ocr_engines_new.engine_type.title':
        return 'Engine type';
      case 'app.ocr_engines_new.option.title':
        return 'Option';
      case 'app.settings.title':
        return 'Settings';
      case 'app.settings.text_version':
        return ({required Object version, required Object buildNumber}) =>
            'Version ${version} BUILD ${buildNumber}';
      case 'app.settings.kLayout.navgroup.client':
        return 'Client';
      case 'app.settings.kLayout.navgroup.integrations':
        return 'Integrations';
      case 'app.settings.kLayout.navgroup.resources':
        return 'Resources';
      case 'app.settings.about.title':
        return 'About';
      case 'app.settings.about.package_info.version':
        return 'Version';
      case 'app.settings.about.package_info.build_number':
        return 'Build Number';
      case 'app.settings.advanced.title':
        return 'Advanced';
      case 'app.settings.advanced.launch_at_login.title':
        return 'Launch at login';
      case 'app.settings.appearance.title':
        return 'Appearance';
      case 'app.settings.appearance.subtitle':
        return 'Change the look of your client.';
      case 'app.settings.appearance.tray_icon.title':
        return 'Tray Icon';
      case 'app.settings.appearance.tray_icon.style.title':
        return 'Tray Icon Style';
      case 'app.settings.appearance.tray_icon.show.title':
        return 'Show Tray Icon';
      case 'app.settings.appearance.max_window_height.title':
        return 'Maximum window height (logical pixels)';
      case 'app.settings.changelog.title':
        return 'Changelog';
      case 'app.settings.changelog.subtitle':
        return 'See what cool new features we\'re making.';
      case 'app.settings.general.title':
        return 'General';
      case 'app.settings.general.subtitle':
        return 'General settings related to the client.';
      case 'app.settings.general.default_detect_text_engine.title':
        return 'Default detect text engine';
      case 'app.settings.general.extract_text.auto_copy_detected_text.title':
        return 'Auto copy the detected text';
      case 'app.settings.general.default_translate_engine.title':
        return 'Default translate engine';
      case 'app.settings.general.translation_mode.title':
        return 'Translation Mode';
      case 'app.settings.general.default_detect_language_engine.title':
        return 'Default detect language engine';
      case 'app.settings.general.translation_target.title':
        return 'Translation target';
      case 'app.settings.general.translate.double_click_copy_result.title':
        return 'Double-click to copy translation result';
      case 'app.settings.general.input_settings.title':
        return 'Input Settings';
      case 'app.settings.general.input_settings.submit_with_enter.title':
        return 'Submit with Enter';
      case 'app.settings.general.input_settings.submit_with_meta_enter.title':
        return 'Submit with Ctrl + Enter';
      case 'app.settings.general.input_settings.submit_with_meta_enter_mac.title':
        return 'Submit with ⌘ + Enter';
      case 'app.settings.keybinds.title':
        return 'Keybinds';
      case 'app.settings.keybinds.subtitle':
        return 'View and manage client keybinds';
      case 'app.settings.keybinds.window.show_or_hide.title':
        return 'Show/Hide';
      case 'app.settings.keybinds.window.hide.title':
        return 'Hide';
      case 'app.settings.keybinds.extract_text.title':
        return 'Screen / Clipboard extract text';
      case 'app.settings.keybinds.extract_text.from_selection.title':
        return 'Selection';
      case 'app.settings.keybinds.extract_text.from_capture.title':
        return 'Capture Area';
      case 'app.settings.keybinds.extract_text.from_clipboard.title':
        return 'Clipboard';
      case 'app.settings.keybinds.input_assist_function.title':
        return 'Input assist function';
      case 'app.settings.keybinds.input_assist_function.translate_input_content.title':
        return 'Translate input content';
      case 'app.settings.language.title':
        return 'Language';
      case 'app.settings.ocr_engines.title':
        return 'Text Detections';
      case 'app.settings.ocr_engines.private.title':
        return 'Private';
      case 'app.settings.ocr_engines.private.description':
        return 'Long press an item to reorder it';
      case 'app.settings.translation_engines.title':
        return 'Text Translations';
      case 'app.settings.translation_engines.private.title':
        return 'Private';
      case 'app.settings.translation_engines.private.description':
        return 'Long press an item to reorder it';
      case 'app.supported_languages.title':
        return 'Supported Languages';
      case 'app.supported_languages.all.title':
        return 'All';
      case 'app.translation_engine_types.title':
        return 'Engine Type';
      case 'app.translation_engines.title':
        return 'Text Translation Engines';
      case 'app.translation_engines.msg.no_available_engines':
        return 'No available engines';
      case 'app.translation_engines.private.title':
        return 'Private';
      case 'app.translation_engines_new.title':
        return 'Add Text Translation Engine';
      case 'app.translation_engines_new.engine_type.title':
        return 'Engine type';
      case 'app.translation_engines_new.support_interface.title':
        return 'Support interface';
      case 'app.translation_engines_new.option.title':
        return 'Option';
      case 'app.translation_targets.kNew.title':
        return 'Add Translation Target';
      case 'app.translation_targets.kNew.title_with_edit':
        return 'Edit Translation Target';
      case 'app.translation_targets.kNew.source_language':
        return 'Source language';
      case 'app.translation_targets.kNew.target_language':
        return 'Target language';
      case 'widget.record_shortcut_dialog.title':
        return 'Customize your shortcut';
      default:
        return null;
    }
  }
}
