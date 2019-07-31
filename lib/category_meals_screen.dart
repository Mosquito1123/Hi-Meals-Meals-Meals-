import 'package:flutter/material.dart';

import './models/category.dart';
import 'dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    print(_routeArgs);

    final Category cat = DUMMY_CATEGORIES
        .where((element) => element.id == _routeArgs['id'])
        .toList()[0];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cat.color,
        title: Text(cat.title),
      ),
      body: Center(
        child: Text('category recipes for category!'),
      ),
    );
  }
}
