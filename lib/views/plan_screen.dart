import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../utils/extension.dart';
import '../utils/fonts.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Training Calendar",
              style: AppTextStyles.font24.copyWith(color: Colors.white),
            ),
            Text(
              "Save",
              style: AppTextStyles.font16.copyWith(
                color: AppColor.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.height,
              _WeekSection(
                weekTitle: "Week 2/8",
                dateRange: "December 8–14",
                total: "60min",
                weekDays: [
                  _DayEvent(
                    day: "Mon",
                    date: "8",
                    tag: "Arm Workout",
                    title: "Arm Blaster",
                    duration: "25m – 30m",
                  ),
                  _DayEvent(day: "Tue", date: "9"),
                  _DayEvent(day: "Wed", date: "10"),
                  _DayEvent(
                    day: "Thu",
                    date: "11",
                    tag: "Leg Workout",
                    title: "Leg Day Blitz",
                    duration: "25m – 30m",
                  ),
                  _DayEvent(day: "Fri", date: "12"),
                  _DayEvent(day: "Sat", date: "13"),
                  _DayEvent(day: "Sun", date: "14"),
                ],
              ),
              10.height,
              _WeekSection(
                weekTitle: "Week 3/8",
                dateRange: "December 14–22",
                total: "60min",
                weekDays: [
                  _DayEvent(day: "Mon", date: "14"),
                  _DayEvent(day: "Tue", date: "15"),
                  _DayEvent(day: "Wed", date: "16"),
                  _DayEvent(day: "Thu", date: "17"),
                  _DayEvent(day: "Fri", date: "18"),
                  _DayEvent(day: "Sat", date: "19"),
                  _DayEvent(day: "Sun", date: "20"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeekSection extends StatelessWidget {
  final String weekTitle, dateRange, total;
  final List<_DayEvent> weekDays;

  const _WeekSection({
    required this.weekTitle,
    required this.dateRange,
    required this.total,
    required this.weekDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Week Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weekTitle,
                    style: AppTextStyles.font20.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    dateRange,
                    style: AppTextStyles.font16.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Text(
                "Total: $total",
                style: AppTextStyles.font16.copyWith(color: Colors.white70),
              ),
            ],
          ),
          10.height,

          // Days List
          Column(
            children: weekDays.map((dayEvent) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left date column
                      SizedBox(
                        width: 40.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              dayEvent.day,
                              style: AppTextStyles.font14.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                            4.height,
                            Text(
                              dayEvent.date,
                              style: AppTextStyles.font16.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Right side workout or empty
                      Expanded(
                        child: dayEvent.hasEvent
                            ? _WorkoutCard(
                          tag: dayEvent.tag!,
                          title: dayEvent.title!,
                          duration: dayEvent.duration!,
                        )
                            : SizedBox(height: 40.h),
                      ),
                    ],
                  ),
                  Divider(color: Colors.white12, thickness: 1, height: 12.h),
                ],
              );
            }).toList(),
          ),
          6.height,
          Divider(color: AppColor.primary, thickness: 1),
        ],
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final String tag, title, duration;

  const _WorkoutCard({
    required this.tag,
    required this.title,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    bool isLegWorkout = tag == "Leg Workout";
    bool isArmWorkout = tag == "Arm Workout";

    Color tagColor = isLegWorkout
        ? Colors.greenAccent
        : isArmWorkout
        ? Colors.lightBlueAccent
        : AppColor.primary;

    Color bgColor = isLegWorkout
        ? Colors.green.withValues(alpha: 0.1)
        : isArmWorkout
        ? Colors.blue.withValues(alpha: 0.1)
        : const Color(0xFF1A1A1A);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12.r),
        border: const Border(
          left: BorderSide(color: Colors.white, width: 8),
        ),
      ),
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Small tag container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              tag,
              style: AppTextStyles.font12.copyWith(
                color: tagColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          6.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.font14.copyWith(color: Colors.white),
              ),
              Text(
                duration,
                style: AppTextStyles.font12.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayEvent {
  final String day;
  final String date;
  final String? tag;
  final String? title;
  final String? duration;

  bool get hasEvent => tag != null && title != null && duration != null;

  _DayEvent({
    required this.day,
    required this.date,
    this.tag,
    this.title,
    this.duration,
  });
}
