import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter101/cards.dart';
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
  ConfettiController _confettiController =
      ConfettiController(duration: Duration(seconds: 4));
  final int size;
  Random random;
  List<PlayCard> cards;
  int currentOpenCardIndex = -1;
  bool gameFinished = false;
  List<int> openedCards = [];

  cardsOnPress(int index) {
    if (openedCards.contains(index)) {
      return;
    }
    if (currentOpenCardIndex == -1) {
      this.setState(() {
        currentOpenCardIndex = index;
      });
      return;
    }
    PlayCard currentOpenCard = this.cards.elementAt(currentOpenCardIndex);
    PlayCard newCardOpen = this.cards.elementAt(index);
    if (currentOpenCardIndex == index ||
        newCardOpen.getNumber() != currentOpenCard.getNumber()) {
      currentOpenCard.flipTheCard();
      newCardOpen.flipTheCard();
    } else {
      openedCards.add(currentOpenCardIndex);
      openedCards.add(index);
      List<PlayCard> newCards = cards.toList();
      newCards[currentOpenCardIndex] = GuessedCards(
          currentOpenCardIndex, currentOpenCard.getNumber(), this.cardsOnPress);
      newCards[index] =
          GuessedCards(index, currentOpenCard.getNumber(), this.cardsOnPress);
      this.setState(() {
        openedCards = openedCards;
        cards = newCards;
      });
    }
    if (this.openedCards.length == size * size) {
      gameHasFinished();
      return;
    }

    this.setState(() {
      currentOpenCardIndex = -1;
    });
  }

  int get cardsLeft {
    return (size * 2) - this.openedCards.length;
  }

  void gameHasFinished() {
    _confettiController.play();
    this.setState(() {
      gameFinished = true;
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Widget get resetButton {
    if (!gameFinished) {
      return Container();
    }
    return RaisedButton(
      onPressed: () {
        this._confettiController.stop();
        this.setState(() => {
              cards = this.getCards(size),
            });
      },
      color: Colors.cyan,
      textColor: Colors.white,
      child: const Text('Start Over', style: TextStyle(fontSize: 20)),
    );
  }

  _GameWindow(this.size) {
    this.cards = this.getCards(size);
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

  List<PlayCard> getCards(int size) {
    List<int> uniqueNumbers = getUniqueNumbers(size);
    List<int> allNumbers = [...uniqueNumbers, ...uniqueNumbers];
    allNumbers.shuffle();
    List<PlayCard> cards = allNumbers
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
          ),
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          blastDirection: 90,
          maxBlastForce: 50,
          emissionFrequency: .05,
          numberOfParticles: this.size,
        ),
        resetButton,
        Text("Total Cards left: " + cardsLeft.toString()),
      ],
    );
  }
}
