import 'package:flutter/material.dart';
import 'favorite_screen.dart';

import 'categories_screen.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedPageIndex = 0;
  final List<Map<String, Object>> _pages = [
    {'title': 'Category', 'pages': CategoriesScreen()},
    {'title': 'Favorite', 'pages': FavoriteScreen()},
  ];

  void _selectPages(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title']),
        ),
        body: _pages[_selectedPageIndex]['pages'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPages,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              backgroundColor: Theme.of(context).primaryColor,
              title: Text('Categories'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                backgroundColor: Theme.of(context).primaryColor,
                title: Text('Favorite'))
          ],
        ));
  }
}
