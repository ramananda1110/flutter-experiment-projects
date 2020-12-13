import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/auth_screen.dart';
import './screens/card_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/order_screen.dart';
import './screens/product_details_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/splash_screen.dart';
import './screens/user_product_screen.dart';
import 'providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          // ignore: missing_required_param
          ChangeNotifierProxyProvider<Auth, Product>(
            // ignore: deprecated_member_use
            builder: (ctx, auth, previousProduct) => Product(
                auth.token,
                auth.userId,
                previousProduct == null ? [] : previousProduct.items),
          ),
          ChangeNotifierProvider(create: (ctx) => Cart()),

          // ignore: missing_required_param
          ChangeNotifierProxyProvider<Auth, Orders>(
            builder: (ctx, auth, previousOrder) => Orders(auth.token,
                auth.userId, previousOrder == null ? [] : previousOrder.orders),
          )
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              accentColor: Colors.amber,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductScreen.routeName: (ctx) => UserProductScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          ),
        ));
  }
}
