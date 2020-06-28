import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String _questionText;

  Question(this._questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.black,
        margin: EdgeInsets.all(10),
        width: double.maxFinite,
        child: Text(
          _questionText,
          style: TextStyle(color: Colors.pink, fontSize: 28),
          textAlign: TextAlign.center,
        ));
  }
}
