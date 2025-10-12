import 'package:evencir_task/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../viewModel/controllers/mood_controller.dart';

class MoodScreen extends StatelessWidget {
  final MoodController controller = Get.put(MoodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.height,
              Text(
                "Mood",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.height,
              Text(
                "Start your day",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              20.height,
              Text(
                "How are you feeling at the Moment?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              40.height,
              /// --- Circular Mood Slider ---
              Center(
                child: Obx(
                      () => SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                      size: 280,
                      startAngle: 270,
                      angleRange: 360,
                      customColors: CustomSliderColors(
                        trackColors: [
                          Color(0xfff99955),
                          Color(0xff6eb9ad),
                          Color(0xffc9bbef),
                          Color(0xfff28db3),
                        ],
                        progressBarColors: [
                          Color(0xfff99955),
                          Color(0xff6eb9ad),
                          Color(0xffc9bbef),
                          Color(0xfff28db3),
                        ],
                        dotColor: Colors.white,
                        hideShadow: true,
                      ),
                      customWidths: CustomSliderWidths(
                        trackWidth: 30,
                        progressBarWidth: 30,
                        handlerSize: 30,
                      ),
                    ),
                    min: 0,
                        max: controller.moods.length.toDouble(),
                        initialValue: controller.moodIndex.value.toDouble(),
                    onChange: (value) {
                      controller.updateMood(value);
                    },
                    innerWidget: (value) {
                      final mood = controller.moods[controller.moodIndex.value];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            mood["image"]!,
                            height: 80,
                            width: 80,
                          ),
                          10.height,
                          Text(
                            mood["name"]!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),


              Spacer(),

              /// --- Continue Button ---
              GestureDetector(
                onTap: () {
                  // handle navigation
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              30.height,
            ],
          ),
        ),
      ),
    );
  }
}
