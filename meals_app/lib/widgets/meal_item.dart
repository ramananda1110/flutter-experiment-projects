import 'package:flutter/material.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/screens/meals_details_screen.dart';

class MealItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final String id;
  final Function removedItem;

  MealItem(
      {this.title,
      this.id,
      this.imageUrl,
      this.duration,
      this.complexity,
      this.affordability,
      this.removedItem});

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(MealDetailsScreen.routName, arguments: id)
        .then((result) {
      if (result != null) {
        removedItem(result);
      }
    });
  }

  String get complexityText {
    if (complexity == Complexity.Simple)
      return 'simplicity';
    else if (complexity == Complexity.Challenging)
      return 'challenging';
    else
      return 'hard';
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return "affordable";
        break;
      case Affordability.Pricey:
        return "pricey";
        break;
      case Affordability.Luxurious:
        return "expensive";
        break;
      default:
        return "unknown";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        margin: EdgeInsets.all(12),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        '$duration min',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        complexityText,
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        affordabilityText,
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
