import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'answer.dart';
import 'question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;

  final Function answerFunctions;
  final questionIndex;

  Quiz({this.questions, this.answerFunctions, this.questionIndex});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Question(questions[questionIndex]['questionText']),

        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerFunctions(answer['score']), answer['text']);
        }).toList()

        // Answer(questionAnswer, questions[questionIndex]['answers']),
      ],
    );
  }
}
