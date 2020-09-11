import 'package:flutter/material.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routName = './meals-details-screen';

  final String duration;
  final String title;

  MealDetailsScreen({this.duration, this.title});

  @override
  Widget build(BuildContext context) {
    final routeArg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final title = routeArg['title'];
    final id = routeArg['id'];

    return Scaffold(
        appBar: AppBar(
          title: Text(id),
        ),
        body: Container(child: Text(title)));
  }
}
