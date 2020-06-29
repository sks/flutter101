import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class GuessingCard extends StatelessWidget {
  final int number;
  final int index;
  final Color color;
  final Function(int) onPress;
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  GuessingCard(this.index, this.number, this.onPress,
      [this.color = Colors.teal]);

  static Widget textBody(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget get numberSide {
    return textBody(this.number.toString());
  }

  static Widget get questionSide {
    return textBody("?");
  }

  static Widget flipCardChild(Widget child, Color color) {
    return Container(
      child: child,
      alignment: Alignment.center,
      color: color,
    );
  }

  void flipTheCard() {
    this.cardKey.currentState.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
        key: cardKey,
        direction: FlipDirection.HORIZONTAL, // default
        front: flipCardChild(questionSide, this.color),
        onFlipDone: (isFront) => isFront || this.onPress(this.index),
        back: flipCardChild(numberSide, this.color));
  }
}
