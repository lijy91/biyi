import 'package:biyi_app/app/router_config.dart';
import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/models/translation_target.dart';
import 'package:biyi_app/services/api_client.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:biyi_app/widgets/widgets.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uikit/uikit.dart';
import 'package:uni_platform/uni_platform.dart';

class GeneralSettingPage extends StatefulWidget {
  const GeneralSettingPage({super.key});

  @override
  State<GeneralSettingPage> createState() => _GeneralSettingPageState();
}

class _GeneralSettingPageState extends State<GeneralSettingPage> {
  void _handleUpdateSettings({
    String? defaultOcrEngineId,
    bool? autoCopyRecognizedText,
    String? defaultTranslationEngineId,
    TranslationMode? translationMode,
    String? defaultDetectLanguageEngineId,
    bool? doubleClickCopyResult,
    InputSubmitMode? inputSubmitMode,
  }) {
    final settings = context.read<Settings>();
    settings.update(
      defaultOcrEngineId: defaultOcrEngineId,
      autoCopyRecognizedText: autoCopyRecognizedText,
      defaultTranslationEngineId: defaultTranslationEngineId,
      translationMode: translationMode,
      defaultDetectLanguageEngineId: defaultDetectLanguageEngineId,
      doubleClickCopyResult: doubleClickCopyResult,
      inputSubmitMode: inputSubmitMode,
    );
  }

  Widget _buildBody(BuildContext context) {
    final settings = context.watch<Settings>();

    return ListView(
      children: [
        ListSection(
          header: Text(
            t.app.settings.general.default_detect_text_engine.title,
          ),
          children: [
            ListTile(
              leading: settings.defaultOcrEngineConfig == null
                  ? null
                  : OcrEngineIcon(settings.defaultOcrEngineConfig!.type),
              title: Builder(
                builder: (_) {
                  if (settings.defaultOcrEngineConfig == null) {
                    return Text(t.please_choose);
                  }
                  return OcrEngineName(
                    settings.defaultOcrEngineConfig!,
                  );
                },
              ),
              trailing: const ListTileChevron(),
              onTap: () async {
                final OcrEngineConfig? ocrEngineConfig =
                    await context.push<OcrEngineConfig?>(
                  '${PageId.availableOcrEngines}?selectedEngineId=${settings.defaultOcrEngineId}',
                );
                if (ocrEngineConfig != null) {
                  _handleUpdateSettings(defaultOcrEngineId: ocrEngineConfig.id);
                }
              },
            ),
          ],
        ),
        ListSection(
          children: [
            SwitchListTile(
              value: settings.autoCopyRecognizedText,
              onChanged: (value) {
                _handleUpdateSettings(autoCopyRecognizedText: value);
              },
              title: Text(
                t.app.settings.general.extract_text.auto_copy_detected_text
                    .title,
              ),
            ),
          ],
        ),
        ListSection(
          header: Text(
            t.app.settings.general.default_translate_engine.title,
          ),
          children: [
            ListTile(
              leading: settings.defaultTranslationEngineConfig == null
                  ? null
                  : TranslationEngineIcon(
                      settings.defaultTranslationEngineConfig!.type,
                    ),
              title: Builder(
                builder: (_) {
                  if (settings.defaultTranslationEngineConfig == null) {
                    return Text(t.please_choose);
                  }
                  return TranslationEngineName(
                    settings.defaultTranslationEngineConfig!,
                  );
                },
              ),
              trailing: const ListTileChevron(),
              onTap: () async {
                final TranslationEngineConfig? engineConfig =
                    await context.push<TranslationEngineConfig?>(
                  '${PageId.availableTranslationEngines}?selectedEngineId=${settings.defaultTranslationEngineId}',
                );
                if (engineConfig != null) {
                  _handleUpdateSettings(
                    defaultTranslationEngineId: engineConfig.id,
                  );
                }
              },
            ),
          ],
        ),
        ListSection(
          hasLeading: false,
          header: Text(
            t.app.settings.general.translation_mode.title,
          ),
          children: [
            RadioListTile<TranslationMode>(
              value: TranslationMode.manual,
              groupValue: settings.translationMode,
              onChanged: (value) =>
                  _handleUpdateSettings(translationMode: value),
              useCheckmarkStyle: true,
              title: Text(t.translation_mode.manual),
            ),
            RadioListTile<TranslationMode>(
              value: TranslationMode.auto,
              groupValue: settings.translationMode,
              onChanged: (value) =>
                  _handleUpdateSettings(translationMode: value),
              useCheckmarkStyle: true,
              title: Text(t.translation_mode.auto),
            ),
          ],
        ),
        if (settings.translationMode == TranslationMode.auto)
          ListSection(
            header: Text(
              t.app.settings.general.default_detect_language_engine.title,
            ),
            children: [
              ListTile(
                leading: settings.defaultDetectLanguageEngineConfig == null
                    ? null
                    : TranslationEngineIcon(
                        settings.defaultDetectLanguageEngineConfig!.type,
                      ),
                title: Builder(
                  builder: (_) {
                    if (settings.defaultDetectLanguageEngineConfig == null) {
                      return Text(t.please_choose);
                    }
                    return TranslationEngineName(
                      settings.defaultDetectLanguageEngineConfig!,
                    );
                  },
                ),
                onTap: () async {
                  final TranslationEngineConfig? engineConfig =
                      await context.push<TranslationEngineConfig?>(
                    '${PageId.availableTranslationEngines}?selectedEngineId=${settings.defaultDetectLanguageEngineId}',
                  );
                  if (engineConfig != null) {
                    _handleUpdateSettings(
                      defaultDetectLanguageEngineId: engineConfig.id,
                    );
                  }
                },
              ),
            ],
          ),
        if (settings.translationMode == TranslationMode.auto)
          ListSection(
            header: Text(
              t.app.settings.general.translation_target.title,
            ),
            children: [
              for (TranslationTarget translationTarget
                  in settings.translationTargets)
                ListTile(
                  title: Builder(
                    builder: (_) {
                      return Row(
                        children: [
                          if (translationTarget.sourceLanguage != null)
                            LanguageLabel(translationTarget.sourceLanguage!),
                          if (translationTarget.targetLanguage != null)
                            Container(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: const Icon(
                                FluentIcons.arrow_right_20_regular,
                                size: 16,
                              ),
                            ),
                          if (translationTarget.targetLanguage != null)
                            LanguageLabel(translationTarget.targetLanguage!),
                        ],
                      );
                    },
                  ),
                  onTap: () async {
                    await context.push<String?>(
                      PageId.settingsTranslationTarget(translationTarget.id!),
                      extra: {
                        'id': translationTarget.id,
                        'sourceLanguage': translationTarget.sourceLanguage,
                        'targetLanguage': translationTarget.targetLanguage,
                      },
                    );
                  },
                ),
              ListTile(
                title: Text(
                  t.add,
                  style: const TextStyle(
                      // color: Theme.of(context).primaryColor,
                      ),
                ),
                onTap: () async {
                  await context.push<TranslationEngineConfig?>(
                    PageId.translationTargetsNew,
                  );
                },
              ),
            ],
          ),
        ListSection(
          children: [
            SwitchListTile(
              value: settings.doubleClickCopyResult,
              onChanged: (value) {
                _handleUpdateSettings(
                  doubleClickCopyResult: value,
                );
              },
              title: Text(
                t.app.settings.general.translate.double_click_copy_result.title,
              ),
            ),
          ],
        ),
        ListSection(
          hasLeading: false,
          header: Text(
            t.app.settings.general.input_settings.title,
          ),
          children: [
            RadioListTile<InputSubmitMode>(
              value: InputSubmitMode.enter,
              groupValue: settings.inputSubmitMode,
              onChanged: (value) =>
                  _handleUpdateSettings(inputSubmitMode: value),
              useCheckmarkStyle: true,
              title: Text(
                t.app.settings.general.input_settings.submit_with_enter.title,
              ),
            ),
            RadioListTile<InputSubmitMode>(
              value: InputSubmitMode.metaEnter,
              groupValue: settings.inputSubmitMode,
              onChanged: (value) =>
                  _handleUpdateSettings(inputSubmitMode: value),
              useCheckmarkStyle: true,
              title: Text(
                UniPlatform.isMacOS
                    ? t.app.settings.general.input_settings
                        .submit_with_meta_enter_mac.title
                    : t.app.settings.general.input_settings
                        .submit_with_meta_enter.title,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      navigationBar: CustomizedAppBar(
        title: Text(t.app.settings.general.title),
      ),
      child: _buildBody(context),
    );
  }
}
