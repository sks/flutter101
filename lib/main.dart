import 'package:flutter/material.dart';
import './questionbank.dart';
import './results.dart';
import './quiz.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _currentQuestion = 0;
  int _totalScore = 0;
  void _answerQuestion(int score) {
    setState(() {
      _currentQuestion++;
      _totalScore += score;
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestion = 0;
      _totalScore = 0;
    });
  }

  static const questions = const [
    QuestionAnswer("what's your favorite color", [
      Answer("red", score: 10),
      Answer("Green", score: 20),
      Answer("blue", score: 30)
    ]),
    QuestionAnswer("what's your favorite car", [
      Answer("toyota", score: 3),
      Answer("honda", score: 20),
      Answer("Ford", score: 1000)
    ]),
    QuestionAnswer("what's your favorite food", [
      Answer("put", score: 30),
      Answer("porotta", score: 10),
      Answer("dosa", score: 100)
    ]),
    // QuestionAnswer(
    //     "questions 1", ["answer1-1", "answer2-2", "answer3-3", "answer4-4"]),
    // QuestionAnswer(
    //     "questions 2", ["answer2-1", "answer2-2", "answer2-3", "answer2-4"]),
    // QuestionAnswer(
    //     "questions 3", ["answer3-1", "answer3-2", "answer3-3", "answer3-4"]),
    // QuestionAnswer(
    //     "questions 4", ["answer4-1", "answer4-2", "answer4-3", "answer4-4"]),
    // QuestionAnswer(
    //     "questions 5", ["answer5-1", "answer5-2", "answer5-3", "answer5-4"]),
    // QuestionAnswer(
    //     "questions 6", ["answer6-1", "answer6-2", "answer6-3", "answer6-4"]),
  ];

  QuestionAnswer get currentQuestion {
    return questions[this._currentQuestion];
  }

  bool get hasMoreQuestion {
    return this._currentQuestion < questions.length;
  }

  Widget get resultsPage {
    return Column(children: <Widget>[
      Results(),
      Text(
        "Total Score :" + _totalScore.toString(),
        style: TextStyle(fontSize: 30),
      ),
      FlatButton(
        onPressed: _resetQuiz,
        child: Text("Reset!!", style: TextStyle(color: Colors.grey)),
        color: Colors.red,
      )
    ]);
  }

  Widget get body {
    return hasMoreQuestion
        ? Quiz(currentQuestion, _answerQuestion)
        : resultsPage;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Question & Answers"),
      ),
      body: body,
    ));
  }
}
