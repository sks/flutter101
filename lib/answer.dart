import 'package:flutter/material.dart';
import './questionbank.dart';

class AnswerUI extends StatelessWidget {
  final Answer answer;
  final void Function(Answer) selectHandler;

  AnswerUI(this.answer, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(30),
      child: RaisedButton(
        color: Colors.blue,
        onPressed: () => this.selectHandler(this.answer),
        textColor: Colors.white,
        child: Text(this.answer.answer),
      ),
    );
  }
}
