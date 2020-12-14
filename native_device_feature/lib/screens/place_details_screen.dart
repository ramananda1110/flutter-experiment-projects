import 'package:flutter/material.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
