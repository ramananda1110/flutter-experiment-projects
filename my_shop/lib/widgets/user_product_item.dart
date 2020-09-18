import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;

  UserProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Are you sure?'),
                          content: Text(
                              'Do you want to remove the item?'),
                          actions: [
                            FlatButton(
                                onPressed: () => {
                                      Navigator.of(context).pop(false),
                                    },
                                child: Text('No')),
                            FlatButton(
                                onPressed: () => {
                                      Provider.of<Products>(context,
                                              listen: false)
                                          .deleteProduct(id),
                                  Navigator.of(context).pop(false),

                                },
                                child: Text('Yes')),
                          ],
                        ));
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
