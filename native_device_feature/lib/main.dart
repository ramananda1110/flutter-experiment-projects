import 'package:flutter/material.dart';
import 'package:native_device_feature/providers/great_places.dart';
import 'package:native_device_feature/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            accentColor: Colors.amber),
        home: PlacesListScreen(),
      ),
    );
  }
}
