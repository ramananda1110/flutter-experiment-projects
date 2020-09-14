import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {

  var _showIsFavorite = false;

  @override
  Widget build(BuildContext context) {
    //final productContainer = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My shop'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                print(selectedValue);
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showIsFavorite = true;
                  } else {
                    _showIsFavorite = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only Favorites'),
                      value: FilterOptions.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text('Show all'),
                      value: FilterOptions.All,
                    ),
                  ])
        ],
      ),
      body: ProductsGrid(_showIsFavorite),
    );
  }
}
