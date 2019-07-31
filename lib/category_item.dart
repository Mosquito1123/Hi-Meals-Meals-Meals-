import 'package:flutter/material.dart';

import './models/category.dart';

class CategoryItme extends StatelessWidget {
  final Category cat;

  CategoryItme(this.cat);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
