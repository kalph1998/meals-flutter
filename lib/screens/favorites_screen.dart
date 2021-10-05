import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoriteScreen({Key? key, required this.favoriteMeals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('favorites'),
      );
    } else {
      return ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              title: favoriteMeals[index].title,
              imageUrl: favoriteMeals[index].imageUrl,
              duration: favoriteMeals[index].duration,
              affordability: favoriteMeals[index].affordability,
              complexity: favoriteMeals[index].complexity,
              id: favoriteMeals[index].id,
            );
          },
          itemCount: favoriteMeals.length);
    }
  }
}
