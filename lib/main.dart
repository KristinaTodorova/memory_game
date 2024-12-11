import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'controllers/level_status_controller.dart';
import 'screens/gamescreen.dart';
import 'screens/levelselectionscreen.dart';
import 'screens/startscreen.dart';

void main() async {

  await Hive.initFlutter();
  await Hive.openBox('levelBox');

  //I persist the Controller here instead of using lazy load because otherwise it gets disposed after the game and I had state problems.
  Get.put(LevelStatusController());
  runApp(const MemoryGameApp());
}

class MemoryGameApp extends StatelessWidget {
  const MemoryGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memory Game',
      initialRoute: '/start',
      getPages: [
        GetPage(name: '/start', page: () => const StartScreen()),
        GetPage(name: '/game', page: () => const GameScreen(),),
        GetPage(name: '/levels', page: () => const LevelSelectionScreen(),),
      ],
    );
  }
}