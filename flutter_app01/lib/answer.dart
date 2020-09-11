import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function functionHandeler;
  final answerText;

  Answer(this.functionHandeler, this.answerText);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(2),
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: functionHandeler,
        child: Text(answerText, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
