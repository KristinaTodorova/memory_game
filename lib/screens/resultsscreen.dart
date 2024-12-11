import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../controllers/level_status_controller.dart';

class ResultsScreen extends StatelessWidget {
  final int movesMade;
  final int timeTaken; 
  final bool allCardsMatched; 
  final String levelName; 

  ResultsScreen({
    Key? key,
    required this.movesMade,
    required this.timeTaken,
    required this.allCardsMatched,
    required this.levelName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (allCardsMatched) {
      // Used future to delay the update until after the build phase because otherwise I get issues with the state and the LevelStatusController
      Future.delayed(Duration.zero, () {
        final LevelStatusController levelStatusController = Get.find();
        levelStatusController.completeLevel(levelName);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Results'),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Level: $levelName',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Time Taken: ${_formatTime(timeTaken)}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Moves Made: $movesMade',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              if (allCardsMatched)
                const Text(
                  'Congratulations! You completed this level!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                )
              else
                const Text(
                  'Too slow - try again! :(',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/levels'); 
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text(
                  'Play Again',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}