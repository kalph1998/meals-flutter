import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorites_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen({Key? key, required this.favoriteMeals}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>>? _pages;

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {
        'page': FavoriteScreen(
          favoriteMeals: widget.favoriteMeals,
        ),
        'title': 'Favorites'
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text(_pages?[_selectedPageIndex]['title']),
      ),
      drawer: const MainDrawer(),
      body: _pages?[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.category),
              label: 'Category'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.star),
              label: 'Favorites')
        ],
      ),
    );
  }
}
