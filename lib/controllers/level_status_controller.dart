import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

class LevelStatusController extends GetxController {
  var levelCompletionStatus = {
    'Easy': false,
    'Medium': false,
    'Hard': false,
  }.obs;

  @override
  void onInit() {
    super.onInit();
    loadLevelStatus();
  }

  void loadLevelStatus() async {
    final box = await Hive.openBox('levelBox');
    levelCompletionStatus['Easy'] = box.get('Easy', defaultValue: false);
    levelCompletionStatus['Medium'] = box.get('Medium', defaultValue: false);
    levelCompletionStatus['Hard'] = box.get('Hard', defaultValue: false);
  }

  void completeLevel(String level) async {
    levelCompletionStatus[level] = true;
    final box = await Hive.openBox('levelBox');
    box.put(level, true);
  }

  bool isLevelCompleted(String level) {
    return levelCompletionStatus[level] ?? false;
  }
}