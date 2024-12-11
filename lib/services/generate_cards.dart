import 'dart:math';
import 'package:memory_game/models/card_model.dart';

List<CardModel> generateCards(int pairsCount) {
  // Predefined list of numbers that are between 11–99 (so the game is a bit more challenging)
  List<int> predefinedNumbers = List.generate(89, (index) => index + 11);

  predefinedNumbers.shuffle(Random());
  List<int> selectedNumbers = predefinedNumbers.take(pairsCount).toList();
  List<int> allNumbers = [...selectedNumbers, ...selectedNumbers];
  allNumbers.shuffle(Random());

  return List.generate(
    allNumbers.length,
    (index) => CardModel(
      id: 'card_$index',
      number: allNumbers[index],
    ),
  );
}