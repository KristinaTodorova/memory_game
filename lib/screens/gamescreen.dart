import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flame/game.dart';
import '../game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String level = Get.arguments ?? 'Easy';

    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Game - $level Level'),
      ),
      body: GameWidget(
        game: MemoryGame(level), 
      ),
    );
  }
}