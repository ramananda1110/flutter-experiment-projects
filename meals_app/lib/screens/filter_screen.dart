import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class FilterScreen extends StatefulWidget {
  final Function saveFilters;

  FilterScreen(this.saveFilters);

  static const routName = './meals-filter-screen';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  Widget buildSwitchListTitle(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filter'),
          actions: [
            IconButton(icon: Icon(Icons.save), onPressed: widget.saveFilters)
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                buildSwitchListTitle('Gluten free',
                    'Only include gluten free meals', _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                buildSwitchListTitle(
                    'Lactose free',
                    'Only include lactose free meals',
                    _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                buildSwitchListTitle(
                    'Vegetarian', 'Only include vegetarian  meals', _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                buildSwitchListTitle(
                    'Vegan', 'Only include vegan  meals', _vegan, (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                })
              ],
            ))
          ],
        ));
  }
}
