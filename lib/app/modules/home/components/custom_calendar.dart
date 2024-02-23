import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/app/data/constants/constants.dart';

class CustomCalendar extends StatefulWidget {
  final Function(DateTime) onDateChange;
  final DateTime? focusDate;

  const CustomCalendar({Key? key, required this.onDateChange, this.focusDate})
      : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime focusDate;

  @override
  void initState() {
    super.initState();
    focusDate = widget.focusDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return EasyDateTimeLine(
      initialDate: focusDate,
      onDateChange: (selectedDate) {
        setState(() {
          focusDate = selectedDate;
        });
        widget.onDateChange(focusDate);
      },
      headerProps: const EasyHeaderProps(showHeader: false),
      activeColor: AppColors.kPrimary,
      dayProps: EasyDayProps(
        height: 100.h,
        inactiveDayDecoration: BoxDecoration(
          color: isDarkMode(context)
              ? AppColors.kBlack
              : Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.kPrimary),
        ),
        todayStyle: DayStyle(
          dayStrStyle: TextStyle(
              color: isDarkMode(context) ? Colors.white : Colors.black,
              fontSize: 12.sp),
          monthStrStyle: TextStyle(
              color: isDarkMode(context) ? Colors.white : Colors.black,
              fontSize: 12.sp),
          dayNumStyle: TextStyle(
            color: isDarkMode(context) ? Colors.white : Colors.black,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        activeDayStyle: DayStyle(
          dayStrStyle: TextStyle(color: Colors.white, fontSize: 12.sp),
          monthStrStyle: TextStyle(color: Colors.white, fontSize: 12.sp),
          dayNumStyle: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        inactiveDayStyle: DayStyle(
          dayStrStyle: TextStyle(
              color: isDarkMode(context) ? Colors.white : Colors.black,
              fontSize: 12.sp),
          monthStrStyle: TextStyle(
              color: isDarkMode(context) ? Colors.white : Colors.black,
              fontSize: 12.sp),
          dayNumStyle: TextStyle(
            color: isDarkMode(context) ? Colors.white : Colors.black,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
