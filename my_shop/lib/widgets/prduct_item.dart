import 'package:flutter/material.dart';
import 'package:my_shop/screens/product_details_screen.dart';

class ProductItems extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItems({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            /* Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => ProductDetailsScreen(title)),
            );*/
            Navigator.of(context)
                .pushNamed(ProductDetailsScreen.routeName, arguments: id);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
