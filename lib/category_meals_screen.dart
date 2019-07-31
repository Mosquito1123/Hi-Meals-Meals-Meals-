import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import './models/category.dart';
import 'dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  @override
  Widget build(BuildContext context) {
    final _routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
//    print(_routeArgs);

    final Category cat = DUMMY_CATEGORIES
        .where((element) => element.id == _routeArgs['id'])
        .toList()[0];

    final List<Meal> _categoryMeals =
        DUMMY_MEALS.where((meal) => meal.categories.contains(cat.id)).toList();
//    print(_categoryMeals.length);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cat.color,
        title: Text(cat.title),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: _categoryMeals.length,
            itemBuilder: (ctx, index) {
              return Card(
                child: Column(
                  children: <Widget>[
                    Text(_categoryMeals[index].title),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
