import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:my_shop/widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user_product';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () =>
            Navigator.of(context).pushNamed(EditProductScreen.routeName),
        )
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) =>
            UserProductItem(title: productData.items[index].title,
              imageUrl: productData.items[index].imageUrl,),
        itemCount: productData.items.length,
      ),
    );
  }
}