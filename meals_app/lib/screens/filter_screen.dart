import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class FilterScreen extends StatelessWidget {
  static const routName = './meals-filter-screen';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Filter'),
        ),
        body: Center(
          child: Container(
            child: Text('Filter screen'),
          ),
        ));
  }
}
