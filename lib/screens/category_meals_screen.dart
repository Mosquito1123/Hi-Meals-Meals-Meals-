import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  List<Meal> _displayedMeals;
  Category cat;
  bool _loadedInitData = false;

  void _removeMeal(mealID) {
    setState(() {
      _displayedMeals.removeWhere((meal) => meal.id == mealID);
//        super.setState();
    });
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final _routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
//    print(_routeArgs);

      cat = DUMMY_CATEGORIES
          .singleWhere((element) => element.id == _routeArgs['id']);

      _displayedMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(cat.id))
          .toList();
//    print(_categoryMeals.length);
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cat.color,
        title: Text(cat.title),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: _displayedMeals.length,
            itemBuilder: (ctx, index) {
              return MealItem(_displayedMeals[index], _removeMeal);
            }),
      ),
    );
  }
}
