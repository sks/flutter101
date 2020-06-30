import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import './cards.dart';

class GuessingCard extends StatelessWidget implements PlayCard {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final int number;
  final int index;
  final Color color;
  final Function(int) onPress;

  GuessingCard(this.index, this.number, this.onPress,
      [this.color = Colors.teal]);

  @override
  void flipTheCard() {
    this.cardKey.currentState.toggleCard();
  }

  Widget get numberSide {
    return textBody(this.number.toString());
  }

  Widget textBody(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget get questionSide {
    return textBody("?");
  }

  Widget flipCardChild(Widget child, Color color) {
    return Container(
      child: child,
      alignment: Alignment.center,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
        key: cardKey,
        direction: FlipDirection.HORIZONTAL, // default
        front: flipCardChild(questionSide, this.color),
        onFlipDone: (isFront) => isFront ? null : this.onPress(this.index),
        back: flipCardChild(numberSide, this.color));
  }

  @override
  int getNumber() {
    return this.number;
  }
}
