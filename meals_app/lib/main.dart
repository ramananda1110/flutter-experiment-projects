import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals app',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.purple,
          primaryColor: Colors.blue,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          // errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                fontFamily: 'Raleway',
                color: Color.fromRGBO(20, 51, 51, 1),
                fontSize: 18,
              ),
              body2: TextStyle(
                  fontFamily: 'Raleway',
                  color: Color.fromRGBO(20, 51, 51, 1),
                  fontSize: 18),
              title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: CategoriesScreen(),
      routes: {CategoryMealsScreen.routName: (ctx) => CategoryMealsScreen()},
    );
  }
}
