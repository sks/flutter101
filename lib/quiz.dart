import 'package:flutter/material.dart';
import 'package:flutter101/questionbank.dart';
import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final QuestionAnswer questionAnswers;
  final void Function(int) selectHandler;

  Quiz(this.questionAnswers, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(questionAnswers.question),
        ...this
            .questionAnswers
            .answers
            .map((e) => AnswerUI(e, (a) => this.selectHandler(e.score)))
            .toList(),
      ],
    );
  }
}
