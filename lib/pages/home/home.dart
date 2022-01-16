import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../includes.dart';

import 'tab_homepage/tab_homepage.dart';
import 'tab_me/tab_me.dart';
import 'tab_vocabulary/tab_vocabulary.dart';

const _kHomeTabHomepage = 0;
const _kHomeTabVocabulary = 1;
const _kHomeTabMe = 2;

class _TabBarItem extends BottomNavigationBarItem {
  _TabBarItem({
    Widget icon,
    String label,
    Widget activeIcon,
  }) : super(icon: icon, label: label, activeIcon: activeIcon);
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  int _selectedIndex = _kHomeTabHomepage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: _selectedIndex,
      length: 3,
      vsync: this,
    );
  }

  Widget _buildBody(BuildContext context) {
    return IndexedStack(
      index: _selectedIndex,
      children: const [
        TabHomepageScene(),
        TabVocabularyScene(),
        TabMeScene(),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 16,
          ),
        ],
      ),
      child: CupertinoTabBar(
        items: [
          _TabBarItem(
            icon: const Icon(FluentIcons.home_20_regular),
            activeIcon: const Icon(FluentIcons.home_20_filled),
            label: 'Home',
          ),
          _TabBarItem(
            icon: const Icon(FluentIcons.book_20_regular),
            activeIcon: const Icon(FluentIcons.book_20_filled),
            label: 'Vocabulary',
          ),
          _TabBarItem(
            icon: const Icon(FluentIcons.person_20_regular),
            activeIcon: const Icon(FluentIcons.person_20_filled),
            label: 'Me',
          ),
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        iconSize: 28,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }

  Widget _build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
