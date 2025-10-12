import 'package:evencir_task/views/nutrition_screen.dart';
import 'package:evencir_task/views/plan_screen.dart';
import 'package:evencir_task/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routers/routers_name.dart';
import '../utils/app_colors.dart';
import '../utils/image_urls.dart';
import 'mood_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const BottomNavigationScreen({super.key, this.initialIndex = 0});

  @override
  BottomNavigationScreenState createState() => BottomNavigationScreenState();
}

class BottomNavigationScreenState extends State<BottomNavigationScreen> {
  late final PageController _pageController;
  late int _selectedIndex;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _selectedIndex);
    _pages = [
      NutritionScreen(),
      PlanScreen(),
      MoodScreen(),
      ProfileScreen(),
    ];
  }

  void _onNavBarTapped(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _buildNavItem(
      {required String selectedIcon,
        required String unselectedIcon,
        required String label,
        required int index}) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        _selectedIndex == index ? selectedIcon : unselectedIcon,
        width: _selectedIndex == index ? 30 : 24,
        height: _selectedIndex == index ? 30 : 24,
      ),
      label: label,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        body: PageView.builder(
          controller: _pageController,
          itemCount: _pages.length,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _pages[index];
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColor.primary,
          selectedItemColor: AppColor.white,
          unselectedItemColor: Colors.grey.shade300,
          selectedLabelStyle:
          const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          onTap: _onNavBarTapped,
          items: [
            _buildNavItem(
                selectedIcon: ImagesUrls.nutrition_s,
                unselectedIcon: ImagesUrls.nutrition,
                label: 'Nutrition',
                index: 0),
            _buildNavItem(
                selectedIcon: ImagesUrls.plan_s,
                unselectedIcon: ImagesUrls.plan,
                label: 'Plan',
                index: 1),
            _buildNavItem(
                selectedIcon: ImagesUrls.mood_s,
                unselectedIcon: ImagesUrls.mood,
                label: 'Mood',
                index: 2),
            _buildNavItem(
                selectedIcon: ImagesUrls.profile,
                unselectedIcon: ImagesUrls.profile,
                label: 'Profile',
                index: 3),
          ],
        ),
      ),
    );
  }
}
