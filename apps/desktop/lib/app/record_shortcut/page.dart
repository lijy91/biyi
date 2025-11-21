import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:uikit/uikit.dart';

class RecordShortcutPage extends StatefulWidget {
  const RecordShortcutPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _RecordShortcutPageState();
}

class _RecordShortcutPageState extends State<RecordShortcutPage> {
  HotKey? _hotKey;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleClickOk() async {
    context.pop<HotKey?>(_hotKey);
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                HotKeyRecorder(
                  onHotKeyRecorded: (hotKey) {
                    _hotKey = hotKey;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      navigationBar: CustomizedAppBar(
        title: Text(
          t.app.record_shortcut.title,
        ),
        actions: [
          Button.primary(
            onPressed: _handleClickOk,
            child: Text(t.ok),
          ),
        ],
      ),
      child: _buildBody(context),
    );
  }
}
