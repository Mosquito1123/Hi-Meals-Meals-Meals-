import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  @override
  Widget build(BuildContext context) {
    String mealId = ModalRoute.of(context).settings.arguments as String;
    Meal meal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        backgroundColor: DUMMY_CATEGORIES
            .firstWhere((cat) => meal.categories[0] == cat.id)
            .color,
      ),
      body: Center(
        child: Text(meal.title),
      ),
    );
  }
}
