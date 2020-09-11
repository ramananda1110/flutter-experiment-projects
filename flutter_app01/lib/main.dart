import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'quiz.dart';
import 'result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyStateApp();
  }
}

class MyStateApp extends State<MyApp> {
  // This widget is the root of your application.

  final _questions = const [
    {
      'questionText': 'Who\'s your favorite instructor?',
      'answers': [
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 2},
        {'text': 'Max', 'score': 3},
        {'text': 'Max', 'score': 5},

      ],
    },
    {
      'questionText': 'What\'s your favourite color?',
      'answers': [
        {'text': 'Black', 'score': 2},
        {'text': 'Red', 'score': 3},
        {'text': 'Yellow', 'score': 4},
        {'text': 'Green', 'score': 5},
      ],
    },
    {
      'questionText': 'What\'s your favourite animals?',
      'answers': [
        {'text': 'Rabbit', 'score': 4},
        {'text': 'Snake', 'score': 3},
        {'text': 'Elephant', 'score': 1},
        {'text': 'Lion', 'score': 5},
      ],
    },
    {
      'questionText': 'Which\'s cricket team is your\'s favourite?',
      'answers': [
        {'text': 'Bangladesh', 'score': 10},
        {'text': 'India', 'score': 4},
        {'text': 'Pakistan', 'score': 2},
        {'text': 'Australia', 'score': 1},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void questionAnswer(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }



  @override
  Widget build(BuildContext context) {
    /*var questions = [
      "What's your favourite color?",
      "What's your favourite animals?",
      "What's your favourite Cricket Team?"
    ];*/

    return MaterialApp(
        title: 'Quiz app',
        home: Scaffold(
            appBar: AppBar(
              title: Text("Quiz app"),
            ),
            body: _questionIndex < _questions.length
                ? Quiz(
                    questions: _questions,
                    answerFunctions: questionAnswer,
                    questionIndex: _questionIndex)
                : Result(result: _totalScore, resetHandler: _resetQuiz)));
  }
}
