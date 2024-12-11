import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/level_status_controller.dart';


class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LevelStatusController levelStatusController = Get.find();
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Level'),
      ),
      body: SafeArea(
        child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: screenWidth > 600
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    levelButton(levelStatusController, 'Easy', Colors.lightGreen),
                    const SizedBox(width: 20),
                    levelButton(levelStatusController, 'Medium', Colors.orange),
                    const SizedBox(width: 20),
                    levelButton(levelStatusController, 'Hard', Colors.red),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    levelButton(levelStatusController, 'Easy', Colors.lightGreen),
                    const SizedBox(height: 20),
                    levelButton(levelStatusController, 'Medium', Colors.orange),
                    const SizedBox(height: 20),
                    levelButton(levelStatusController, 'Hard', Colors.red),
                  ],
                ),
        ),
      ),
    ),
    );
  }

  Widget levelButton(LevelStatusController levelStatusController, String level, Color color) {
    return Obx(() {
      final isCompleted = levelStatusController.isLevelCompleted(level);
      return ElevatedButton(
        onPressed: () {
          Get.toNamed('/game', arguments: level);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: color,
        ),
        child: Text(
          isCompleted ? '$level (completed)' : level,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      );
    });
  }
}