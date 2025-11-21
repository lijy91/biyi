import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';

import 'package:go_router/go_router.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:provider/provider.dart';
import 'package:uikit/uikit.dart';
import 'package:uni_platform/uni_platform.dart';

class HotKeyDisplayView extends StatelessWidget {
  const HotKeyDisplayView(
    this.hotKey, {
    super.key,
  });

  final HotKey hotKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final HotKeyModifier modifier in hotKey.modifiers ?? []) ...[
          Kbd(
            modifier.physicalKeys.first.keyLabel,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '+',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto Mono',
              ),
            ),
          ),
        ],
        Kbd(
          hotKey.physicalKey.keyLabel,
        ),
      ],
    );
  }
}

class KeybindsSettingPage extends StatefulWidget {
  const KeybindsSettingPage({super.key});

  @override
  State<KeybindsSettingPage> createState() => _KeybindsSettingPageState();
}

class _KeybindsSettingPageState extends State<KeybindsSettingPage> {
  Future<void> _handleClickRegisterNewHotKey(
    BuildContext context, {
    HotKeyScope shortcutScope = HotKeyScope.system,
    ValueChanged<HotKey?>? onHotKeyRecorded,
  }) async {
    final HotKey? recordedShortcut = await context.push<HotKey?>(
      '/record-shortcut',
      extra: {},
    );
    if (recordedShortcut != null) {
      onHotKeyRecorded?.call(
        HotKey(
          key: recordedShortcut.key,
          modifiers: recordedShortcut.modifiers,
          scope: shortcutScope,
        ),
      );
    }
  }

  Widget _buildBody(BuildContext context) {
    final Settings settings = context.watch<Settings>();
    final BoundShortcuts boundShortcuts = settings.boundShortcuts;

    return ListView(
      children: [
        ListSection(
          hasLeading: false,
          children: [
            ListTile(
              title: Text(
                t.app.settings.keybinds.window.show_or_hide.title,
              ),
              additionalInfo: HotKeyDisplayView(boundShortcuts.showOrHide),
              onTap: () {
                _handleClickRegisterNewHotKey(
                  context,
                  onHotKeyRecorded: (value) => context
                      .read<Settings>()
                      .updateShortcuts(showOrHide: value),
                );
              },
            ),
            ListTile(
              title: Text(
                t.app.settings.keybinds.window.hide.title,
              ),
              additionalInfo: HotKeyDisplayView(boundShortcuts.hide),
              onTap: () {
                _handleClickRegisterNewHotKey(
                  context,
                  shortcutScope: HotKeyScope.inapp,
                  onHotKeyRecorded: (value) =>
                      context.read<Settings>().updateShortcuts(hide: value),
                );
              },
            ),
          ],
        ),
        ListSection(
          hasLeading: false,
          header: Text(
            t.app.settings.keybinds.extract_text.title,
          ),
          children: [
            ListTile(
              title: Text(
                t.app.settings.keybinds.extract_text.from_selection.title,
              ),
              additionalInfo: HotKeyDisplayView(
                boundShortcuts.extractFromScreenSelection,
              ),
              onTap: () {
                _handleClickRegisterNewHotKey(
                  context,
                  onHotKeyRecorded: (value) => context
                      .read<Settings>()
                      .updateShortcuts(extractFromScreenSelection: value),
                );
              },
            ),
            if (!UniPlatform.isLinux)
              ListTile(
                title: Text(
                  t.app.settings.keybinds.extract_text.from_capture.title,
                ),
                additionalInfo: HotKeyDisplayView(
                  boundShortcuts.extractFromScreenCapture,
                ),
                onTap: () {
                  _handleClickRegisterNewHotKey(
                    context,
                    onHotKeyRecorded: (value) => context
                        .read<Settings>()
                        .updateShortcuts(extractFromScreenCapture: value),
                  );
                },
              ),
            ListTile(
              title: Text(
                t.app.settings.keybinds.extract_text.from_clipboard.title,
              ),
              additionalInfo: HotKeyDisplayView(
                boundShortcuts.extractFromClipboard,
              ),
              onTap: () {
                _handleClickRegisterNewHotKey(
                  context,
                  onHotKeyRecorded: (value) => context
                      .read<Settings>()
                      .updateShortcuts(extractFromClipboard: value),
                );
              },
            ),
          ],
        ),
        if (!UniPlatform.isLinux)
          ListSection(
            hasLeading: false,
            header: Text(
              t.app.settings.keybinds.input_assist_function.title,
            ),
            children: [
              ListTile(
                title: Text(
                  t.app.settings.keybinds.input_assist_function
                      .translate_input_content.title,
                ),
                additionalInfo: HotKeyDisplayView(
                  boundShortcuts.translateInputContent,
                ),
                onTap: () {
                  _handleClickRegisterNewHotKey(
                    context,
                    onHotKeyRecorded: (value) => context
                        .read<Settings>()
                        .updateShortcuts(translateInputContent: value),
                  );
                },
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
        title: Text(t.app.settings.keybinds.title),
      ),
      child: _buildBody(context),
    );
  }
}
