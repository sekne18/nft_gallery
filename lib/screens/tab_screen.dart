import 'package:flutter/material.dart';
import 'package:nft_gallery/provider/theme_provider.dart';

import 'collection_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages = [{}];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': const CollectionScreen(),
        'title': 'Collection',
      },
      {
        'page': const SearchScreen(),
        'title': 'Search',
      },
      {
        'page': const ProfileScreen(),
        'title': 'Profile',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: _pages[_selectedPageIndex]['page'] as Widget,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 58,
            child: BottomNavigationBar(
              onTap: _selectPage,
              selectedFontSize: 0,
              selectedIconTheme: Theme.of(context).iconTheme.copyWith(size: 25),
              unselectedIconTheme: Theme.of(context).iconTheme,
              selectedItemColor: Theme.of(context).iconTheme.color,
              currentIndex: _selectedPageIndex,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.filter,
                  ),
                  title: SizedBox.shrink(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: SizedBox.shrink(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
