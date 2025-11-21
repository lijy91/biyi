import 'package:biyi_app/app/router_config.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';
import 'package:uni_platform/uni_platform.dart';
import 'package:window_manager/window_manager.dart';

class ToolbarItemSettings extends StatefulWidget {
  const ToolbarItemSettings({
    super.key,
  });

  @override
  State<ToolbarItemSettings> createState() => _ToolbarItemSettingsState();
}

class _ToolbarItemSettingsState extends State<ToolbarItemSettings> {
  Future<void> _handleClick() async {
    await UniPlatform.call<Future<void>>(
      desktop: () async {
        await windowManager.setOpacity(0);
      },
      otherwise: () => Future(() => null),
    );
    await Future.delayed(Duration.zero);
    // ignore: use_build_context_synchronously
    context.go(PageId.settingsGeneral);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.text(
      onPressed: _handleClick,
      icon: const Icon(
        FluentIcons.settings_20_regular,
      ),
    );
  }
}
