import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter101/guessing_card.dart';

const double spacing = 10;

class GameWindow extends StatefulWidget {
  final int size;

  GameWindow(this.size);

  @override
  _GameWindow createState() {
    return _GameWindow(this.size);
  }
}

class _GameWindow extends State<StatefulWidget> {
  ConfettiController _controller;
  final int size;
  Random random;
  List<GuessingCard> cards;
  int currentOpenCardIndex = -1;
  int cardsLeft;

  cardsOnPress(int index) {
    print("Opened the card at index " + index.toString());
    if (currentOpenCardIndex == -1) {
      this.setState(() {
        currentOpenCardIndex = index;
      });
      return;
    }
    GuessingCard currentOpenCard = this.cards.elementAt(currentOpenCardIndex);
    GuessingCard newCardOpen = this.cards.elementAt(index);
    if (currentOpenCardIndex == index) {
      currentOpenCard.flipTheCard();
      newCardOpen.flipTheCard();
    } else if (newCardOpen.number != currentOpenCard.number) {
      currentOpenCard.flipTheCard();
      newCardOpen.flipTheCard();
    } else {
      this.setState(() {
        cardsLeft = cardsLeft - 2;
      });
    }
    if (this.cardsLeft == 0) {
      _controller.play();
    }

    this.setState(() {
      currentOpenCardIndex = -1;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _GameWindow(this.size) {
    _controller = ConfettiController(duration: Duration(seconds: 4));
    this.cards = this.getCards(size);
    this.cardsLeft = this.size * this.size;
  }

  static double totalUniqueCardsRequired(int size) => (size * size / 2);

  static List<int> getUniqueNumbers(int size) {
    List<int> list = [];
    Random random = Random.secure();
    double uniqueNumbers = totalUniqueCardsRequired(size);
    while (uniqueNumbers > list.length) {
      int val = random.nextInt(size * size * 2);
      if (!list.contains(val)) {
        list.add(val);
      }
    }
    return list;
  }

  List<GuessingCard> getCards(int size) {
    List<int> uniqueNumbers = getUniqueNumbers(size);
    List<int> allNumbers = [...uniqueNumbers, ...uniqueNumbers];
    allNumbers.shuffle();
    List<GuessingCard> cards = allNumbers
        .asMap()
        .map((k, v) => MapEntry(k, GuessingCard(k, v, this.cardsOnPress)))
        .values
        .toList();
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(spacing * 2),
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          crossAxisCount: size,
          children: cards,
        )),
        ConfettiWidget(
          confettiController: _controller,
          blastDirectionality: BlastDirectionality.explosive,
          blastDirection: 90,
          maxBlastForce: 50,
          emissionFrequency: .05,
          numberOfParticles: 8,
          shouldLoop: true,
        ),
        Text("Total Cards left: " + cardsLeft.toString()),
      ],
    );
  }
}
