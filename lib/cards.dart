import 'package:flutter/material.dart';
import 'package:flutter101/guessing_card.dart';

abstract class PlayCard extends Widget {
  int getNumber();
  flipTheCard() {}
}

class GuessedCards extends GuessingCard {
  GuessedCards(int index, number, Function(int) onPress,
      [Color color = Colors.teal])
      : super(index, number, onPress, color);

  @override
  void flipTheCard() {
    print("i am already guesed");
  }

  @override
  int getNumber() {
    return this.number;
  }

  @override
  Widget build(BuildContext context) {
    return flipCardChild(numberSide, this.color.withOpacity(.4));
  }
}
