import 'package:evencir_task/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../utils/fonts.dart';

class NutritionController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedWeek = "1/4".obs;

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void openCalendar(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        height: 420.h,
        child: Column(
          children: [
            Container(
              width: 40.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            16.height,
            Obx(() {
              final date = selectedDate.value;
              final monthYear = "${_getMonthName(date.month)} ${date.year}";
              return Text(
                monthYear,
                style: AppTextStyles.font18.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              );
            }),
            10.height,
            Expanded(
              child: SfDateRangePicker(
                onSelectionChanged: (args) {
                  if (args.value is DateTime) {
                    selectDate(args.value);
                    Get.back();
                  }
                },
                onViewChanged: (viewChangedDetails) {
                  final midDate =
                  viewChangedDetails.visibleDateRange.startDate!;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    selectedDate.value = midDate;
                  });
                },
                selectionColor: Colors.greenAccent,
                todayHighlightColor: Colors.greenAccent,
                backgroundColor: Colors.black,
                showNavigationArrow: true,
                showActionButtons: false,
                headerHeight: 0,
                monthViewSettings: const DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1,
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                monthCellStyle: const DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(color: Colors.white),
                  todayTextStyle: TextStyle(color: Colors.greenAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }
}