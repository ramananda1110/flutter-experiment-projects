import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int result;

  final Function resetHandler;

  Result({this.result, this.resetHandler});

  String reusltRefresh() {
    String resultText = "You did it = $result";

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(12),
          child: Text(
            reusltRefresh(),
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        FlatButton(
          child: Text(
            'Restart Quiz!',
          ),
          textColor: Colors.blue,
          onPressed: resetHandler,
        ),
      ],
    ));
  }
}
