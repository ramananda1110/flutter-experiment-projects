import 'package:flutter/material.dart';
import 'package:my_shop/widgets/order_item_row.dart';
import '../providers/orders.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => OrderItemRow(
          order: orderData.orders[index],
        ),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
