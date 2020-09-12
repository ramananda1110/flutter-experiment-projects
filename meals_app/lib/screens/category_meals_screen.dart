import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routName = './category-meals';
  final String id;
  final String title;

  CategoryMealsScreen({this.id, this.title});

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayMeals;

  @override
  void initState() {
    // don't working modal route data sync there
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final routeArg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    categoryTitle = routeArg['title'];
    final catId = routeArg['id'];

    displayMeals = DUMMY_MEALS.where((element) {
      return element.categories.contains(catId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              title: displayMeals[index].title,
              imageUrl: displayMeals[index].imageUrl,
              duration: displayMeals[index].duration,
              affordability: displayMeals[index].affordability,
              complexity: displayMeals[index].complexity,
              id: displayMeals[index].id,
              removedItem: _removeMeal,
            );
          },
          itemCount: displayMeals.length),
    );
  }
}
