import 'package:evencir_task/routers/routers_name.dart';
import 'package:evencir_task/views/bottom_navigation_screen.dart';
import 'package:evencir_task/views/mood_screen.dart';
import 'package:evencir_task/views/nutrition_screen.dart';
import 'package:evencir_task/views/plan_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static appRoute() => [
        GetPage(
          name: RouteName.bottomNavigationScreen,
          page: () => const BottomNavigationScreen(),
        ),
    GetPage(
          name: RouteName.planScreen,
          page: () => const PlanScreen(),
        ),
    GetPage(
          name: RouteName.nutritionScreen,
          page: () =>  NutritionScreen(),
        ),
    GetPage(
          name: RouteName.moodScreen,
          page: () =>  MoodScreen(),
        ),

      ];
}
