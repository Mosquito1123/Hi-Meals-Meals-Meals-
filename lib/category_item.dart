import 'package:flutter/material.dart';

import './models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category cat;

  CategoryItem(this.cat);

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/category-meals',
      arguments: {'id': cat.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          cat.title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [cat.color.withOpacity(0.7), cat.color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
