import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routName = './category-meals';
  final String id;
  final String title;

  CategoryMealsScreen({this.id, this.title});

  @override
  Widget build(BuildContext context) {
    final routeArg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final catTitle = routeArg['title'];
    final catId = routeArg['id'];

    final categoryMeals = DUMMY_MEALS.where((element) {
      return element.categories.contains(catId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(catTitle),
      ),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              affordability: categoryMeals[index].affordability,
              complexity: categoryMeals[index].complexity,
              id: categoryMeals[index].id,
            );
          },
          itemCount: categoryMeals.length),
    );
  }
}
