import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/category_meals_screen.dart';
import 'package:meals/screens/filter_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favorites = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
        //...
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favorites.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favorites.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favorites.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favorites.any((element) => element.id == id);
  }

  final ThemeData theme = ThemeData(
    fontFamily: 'Raleway',
    textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText2: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          headline6: const TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold),
        ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.copyWith(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.pink,
          secondary: Colors.amber,
        ),
      ),
      // home: const CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(
              favoriteMeals: _favorites,
            ),
        CategoryMealsScreen.routeName: (ctx) {
          return CategoryMealsScreen(_availableMeals);
        },
        MealDetailScreen.routeName: (ctx) {
          return MealDetailScreen(
            toggleFavorite: _toggleFavorite,
            isFavorite: _isMealFavorite,
          );
        },
        FilterScreen.routeName: (ctx) {
          return FilterScreen(
            saveFilters: _setFilters,
            currentFilters: _filters,
          );
        }
      },
      onGenerateRoute: (settings) {
        // print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx)=> const CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
