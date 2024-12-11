import 'package:get/get.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:async';

import 'models/card_model.dart';
import 'screens/resultsscreen.dart';
import 'services/generate_cards.dart';
import 'widgets/card_component.dart';

class MemoryGame extends FlameGame {
  final String level;
  late TimerComponent timer;
  int moves = 0;
  List<CardModel> cards = [];
  CardModel? firstFlippedCard;
  CardModel? secondFlippedCard;

  MemoryGame(this.level);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(CameraComponent.withFixedResolution(
      width: 800,
      height: 600,
    ));

    int pairsCount;
    int gridColumns;
    int gridRows; 

switch (level) {
  case 'Medium':
    pairsCount = 6;
    gridColumns = 3; 
    gridRows = 4;
    break;
  case 'Hard':
    pairsCount = 8;
    gridColumns = 4;
    gridRows = 4;
    break;
  case 'Easy':
  default:
    pairsCount = 4;
    gridColumns = 2; 
    gridRows = 4;  
}

cards = generateCards(pairsCount);

double cardWidth = size.x / gridColumns - 10;
double cardHeight = size.y / gridRows - 10;   

for (int i = 0; i < cards.length; i++) {
  final card = cards[i];

  final x = (i % gridColumns) * cardWidth + 5;
  final y = (i ~/ gridColumns) * cardHeight + 5; 

  add(CardComponent(card, Vector2(x, y), Vector2(cardWidth, cardHeight), this));
}

    timer = TimerComponent(
      period: 120,
      repeat: false,
      onTick: () {
        Get.offAll(() => ResultsScreen(
              movesMade: moves,
              timeTaken: 120,
              allCardsMatched: checkAllMatched(),
              levelName: level,
            ));
      },
    );
    add(timer);
  }

  void flipCard(CardModel card) {
    if (firstFlippedCard == null) {
      firstFlippedCard = card;
      card.isFlipped = true;
    } else if (secondFlippedCard == null) {
      secondFlippedCard = card;
      card.isFlipped = true;
      moves++;

      if (firstFlippedCard!.number == secondFlippedCard!.number) {
        firstFlippedCard!.isMatched = true;
        secondFlippedCard!.isMatched = true;
        firstFlippedCard = null;
        secondFlippedCard = null;

        if (checkAllMatched()) {
          navigateToResults();
        }
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          firstFlippedCard!.reset();
          secondFlippedCard!.reset();
          firstFlippedCard = null;
          secondFlippedCard = null;
        });
      }
    }
  }

  bool checkAllMatched() {
    return cards.every((card) => card.isMatched);
  }

  void navigateToResults() {
  final int timeinseconds = (timer.timer.progress * 300).round();

    Get.offAll(() => ResultsScreen(
          movesMade: moves,
          timeTaken: timeinseconds,
          allCardsMatched: checkAllMatched(),
          levelName: level,
        ));
  }
} 