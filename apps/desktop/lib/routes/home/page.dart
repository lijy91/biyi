import 'package:uikit/uikit.dart';

import './tab_homepage.dart';
import './tab_settings.dart';
import './tab_vocabulary.dart';

const _kHomeTabHomepage = 0;

class TabBarItem extends BottomNavigationBarItem {
  const TabBarItem({
    required super.icon,
    required String super.label,
    required Widget super.activeIcon,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _selectedIndex = _kHomeTabHomepage;

  Widget _buildBody(BuildContext context) {
    return IndexedStack(
      index: _selectedIndex,
      children: const [
        TabHomepageScene(),
        TabVocabularyScene(),
        TabSettingsScene(),
      ],
    );
  }

  Widget _build(BuildContext context) {
    return PageScaffold(child: _buildBody(context));
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
