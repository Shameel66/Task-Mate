import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/app/data/constants/constants.dart';

class DailyCard extends StatelessWidget {
  final int doneTask;
  final int totalTask;
  const DailyCard({super.key, required this.doneTask, required this.totalTask});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: isDarkMode(context)
              ? AppColors.kBlack
              : Colors.grey.withOpacity(0.1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('All Task', style: AppTypography.kSemiBold18),
          SizedBox(height: 5.h),
          Text('$doneTask/$totalTask Task Completed',
              style: AppTypography.kRegular16.copyWith(color: Colors.grey)),
         
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('You are almost done go ahead',
                  style: AppTypography.kLight14.copyWith(color: Colors.grey)),
              Text(
                '${((doneTask / totalTask) * 100).toStringAsFixed(0)}%',
                style: AppTypography.kRegular16.copyWith(color: Colors.grey),
              )
            ],
          ),
          SizedBox(height: 10.h),
          LinearProgressIndicator(
            value: doneTask / totalTask,
            minHeight: 18.h,
            valueColor: AlwaysStoppedAnimation(AppColors.kPrimary),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ],
      ),
    );
  }
}
