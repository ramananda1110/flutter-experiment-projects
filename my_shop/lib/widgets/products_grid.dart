import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

import 'prduct_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool isFavorite;

  ProductsGrid(this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = isFavorite ? productData.favoriteItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        //create: (c) => products[index],
        child: ProductItems(
            /*id: products[index].id,
            title: products[index].title,
            imageUrl: products[index].imageUrl*/
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
