import 'package:flutter/material.dart';

import './models/category.dart';

class CategoryMealsScreen extends StatelessWidget {
  final Category cat;

  CategoryMealsScreen(this.cat);

  @override
  Widget build(BuildContext context) {
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
