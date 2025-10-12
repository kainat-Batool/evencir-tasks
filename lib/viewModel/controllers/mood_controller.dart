import 'package:get/get.dart';

class MoodController extends GetxController {
  var moodIndex = 0.obs;

  final moods = [
    {
      "name": "Calm",
      "image": "assets/images/calm.png",
    },
    {
      "name": "Peaceful",
      "image": "assets/images/peaceful.png",
    },
    {
      "name": "Happy",
      "image": "assets/images/happy.png",
    },
    {
      "name": "Content",
      "image": "assets/images/content.png",
    },
  ];

  void updateMood(double value) {
    moodIndex.value = value.toInt() % moods.length;
  }
}
