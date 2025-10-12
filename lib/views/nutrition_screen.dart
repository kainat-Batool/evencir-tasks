import 'package:evencir_task/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:evencir_task/utils/extension.dart';
import '../utils/fonts.dart';
import '../viewModel/controllers/nutrition_controller.dart';

class NutritionScreen extends StatelessWidget {
  final controller = Get.put(NutritionController());

  NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.height,
              _buildHeader(),
              20.height,
              _buildModernDateUI(),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Workouts",
                      style: AppTextStyles.font22Normal
                          .copyWith(color: AppColor.white)),
                  Row(
                    children: [
                      Icon(Icons.sunny, color: AppColor.white, size: 20.sp),
                      4.width,
                      Text("9°",
                          style: AppTextStyles.font16
                              .copyWith(color: AppColor.white)),
                    ],
                  ),
                ],
              ),
              10.height,
              _buildWorkoutCard(),
              25.height,
              _buildInsights(),
              20.height,
              const HydrationCard(),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- Header ----------------
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.notifications_none, color: AppColor.white, size: 22.sp),
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: () => controller.openCalendar(Get.context!),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Text(
                        "Week ${controller.selectedWeek.value}",
                        style: AppTextStyles.font16
                            .copyWith(color: AppColor.white),
                      )),
                  4.width,
                  Icon(Icons.keyboard_arrow_down,
                      color: AppColor.white, size: 22.sp),
                ],
              ),
            ),
          ),
        ),
        40.width,
      ],
    );
  }

  /// ---------------- Date Picker ----------------
  Widget _buildModernDateUI() {
    return Obx(() {
      final selectedDate = controller.selectedDate.value;
      final today = DateTime.now();
      final formatter = DateFormat('EEE, dd MMM yyyy');
      final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
      final weekDays =
          List.generate(7, (i) => startOfWeek.add(Duration(days: i)));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today, ${formatter.format(selectedDate)}",
              style: AppTextStyles.font18.copyWith(color: AppColor.white)),
          15.height,
          SizedBox(
            height: 85.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(weekDays.length, (index) {
                final date = weekDays[index];
                final isSelected = selectedDate.day == date.day &&
                    selectedDate.month == date.month;
                return GestureDetector(
                  onTap: () => controller.selectDate(date),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('E')
                            .format(date)
                            .substring(0, 2)
                            .toUpperCase(),
                        style: AppTextStyles.font12
                            .copyWith(color: AppColor.white),
                      ),
                      6.height,
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.transparent
                              : const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(50),
                          border: isSelected
                              ? Border.all(color: Colors.greenAccent, width: 2)
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text("${date.day}",
                            style: AppTextStyles.font16.copyWith(
                              color: isSelected ? Colors.white : Colors.white70,
                            )),
                      ),
                      5.height,
                      if (isSelected)
                        Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      );
    });
  }

  /// ---------------- Workout Card ----------------
  Widget _buildWorkoutCard() {
    return Container(
      padding: EdgeInsets.all(14.w),
      height: 90.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16.r),
        border: const Border(
          left: BorderSide(color: AppColor.blue, width: 6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("December 22 • 25m - 30m",
                  style: AppTextStyles.font12.copyWith(color: Colors.white54)),
              6.height,
              Text("Upper Body",
                  style: AppTextStyles.font18.copyWith(color: AppColor.white)),
            ],
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16.sp),
        ],
      ),
    );
  }

  /// ---------------- Insights ----------------
  Widget _buildInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("My Insights",
            style: AppTextStyles.font22Normal.copyWith(color: Colors.white)),
        15.height,
        Row(
          children: [
            const Expanded(
              child: _InsightCard(
                value: "550",
                label: "Calories",
                subLabel: "1950 Remaining",
                progress: 0.22,
                maxValue: "2500",
                isWeightCard: false,
              ),
            ),
            10.width,
            const Expanded(
              child: _InsightCard(
                value: "75",
                label: "kg",
                subLabel: "+1.6 kg",
                progress: 0.7,
                maxValue: "100kg",
                isWeightCard: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// ------------------- INSIGHT CARD -------------------
class _InsightCard extends StatelessWidget {
  final String value, label, subLabel, maxValue;
  final double progress;
  final bool isWeightCard;

  const _InsightCard({
    required this.value,
    required this.label,
    required this.subLabel,
    required this.progress,
    this.maxValue = '500',
    this.isWeightCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColor.grey,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: isWeightCard ? _buildWeightCard() : _buildCaloriesCard(),
    );
  }

  Widget _buildCaloriesCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(value,
                style: AppTextStyles.font26.copyWith(color: AppColor.white)),
            6.width,
            Text(label,
                style: AppTextStyles.font14.copyWith(color: Colors.white70)),
          ],
        ),
        4.height,
        Text(subLabel,
            style: AppTextStyles.font14.copyWith(color: Colors.white54)),
        12.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("0",
                style: AppTextStyles.font12.copyWith(color: Colors.white54)),
            Text(maxValue,
                style: AppTextStyles.font12.copyWith(color: Colors.white54)),
          ],
        ),
        4.height,
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[800],
            valueColor: const AlwaysStoppedAnimation<Color>(AppColor.blue),
            minHeight: 6.h,
          ),
        ),
      ],
    );
  }

  Widget _buildWeightCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(value,
                style: AppTextStyles.font26.copyWith(color: AppColor.white)),
            6.width,
            Text("kg",
                style: AppTextStyles.font14.copyWith(color: Colors.white70)),
          ],
        ),
        6.height,
        Row(
          children: [
            Icon(Icons.arrow_upward, color: Colors.green, size: 16.sp),
            4.width,
            Text("+1.6 kg",
                style: AppTextStyles.font14.copyWith(color: Colors.green)),
          ],
        ),
        14.height,
        Text("Weight",
            style: AppTextStyles.font18.copyWith(color: AppColor.white)),
      ],
    );
  }
}

/// ------------------- HYDRATION CARD -------------------

class HydrationCard extends StatelessWidget {
  final double progress;
  final int currentMl;
  final double goalLiters;

  const HydrationCard({
    super.key,
    this.progress = 0.25,
    this.currentMl = 500,
    this.goalLiters = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.grey,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${(progress * 100).toInt()}%',
                  style: AppTextStyles.font26.copyWith(
                    color: AppColor.blue,
                    fontSize: 38.sp,
                  ),
                ),
                14.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hydration',
                      style: AppTextStyles.font18.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    6.height,
                    Text(
                      'Log Now',
                      style: AppTextStyles.font14.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                /// Vertical progress bar
                Column(
                  children: [
                    Text(
                      '${goalLiters.toStringAsFixed(0)} L',
                      style: AppTextStyles.font12.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    6.height,
                    Container(
                      height: 90.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          FractionallySizedBox(
                            heightFactor: progress,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF00AEEF),
                                    Color(0xFF38D9FE),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    6.height,
                    Text(
                      '0 L',
                      style: AppTextStyles.font12.copyWith(
                        color: AppColor.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '$currentMl ml',
                style: AppTextStyles.font14.copyWith(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
          10.height,
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: const BoxDecoration(
              color: Color(0xFF204C4C),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                '$currentMl ml added to water log',
                style: AppTextStyles.font16.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
