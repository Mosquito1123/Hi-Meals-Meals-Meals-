import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filter';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  Widget _buildSwitchListTile(
      String title, String description, bool currentValue, Function handler) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: handler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                    'Gluten-free',
                    'Only include GLuten-free meals.',
                    _isGlutenFree, (newValue) {
                  setState(() {
                    _isGlutenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Lactose-free',
                    'Only include Lactose-free meals.',
                    _isLactoseFree, (newValue) {
                  setState(() {
                    _isLactoseFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegan',
                    'Only include Vegan meals.',
                    _isVegan, (newValue) {
                  setState(() {
                    _isVegan = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegetarian',
                    'Only include Vegetarian meals.',
                    _isVegetarian, (newValue) {
                  setState(() {
                    _isVegetarian = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
