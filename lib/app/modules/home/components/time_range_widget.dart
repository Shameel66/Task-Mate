import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/modules/widgets/dialogs/error_dialog.dart';

class TimeRangeWidget extends StatefulWidget {
  final DateTime? initialStartTime;
  final DateTime? initialEndTime;
  final Function(DateTime, DateTime) onTimeRangeChanged;

  const TimeRangeWidget({
    Key? key,
    this.initialStartTime,
    this.initialEndTime,
    required this.onTimeRangeChanged,
  }) : super(key: key);

  @override
  _TimeRangeWidgetState createState() => _TimeRangeWidgetState();
}

class _TimeRangeWidgetState extends State<TimeRangeWidget> {
  late DateTime startTime;
  late DateTime endTime;

  @override
  void initState() {
    super.initState();
    startTime = widget.initialStartTime ?? DateTime.now();
    endTime = widget.initialEndTime ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          child: buildTimeColumn('Start Time', startTime,
              () => selectTime(true), isDarkMode(context)),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: buildTimeColumn('End Time', endTime, () => selectTime(false),
              isDarkMode(context)),
        ),
      ],
    );
  }

  Widget buildTimeColumn(String labelText, DateTime selectedTime,
      VoidCallback onTap, bool isDarkMode) {
    String formattedTime = DateFormat.jm().format(selectedTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppTypography.kRegular16.copyWith(color: Colors.grey),
        ),
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  isDarkMode ? AppColors.kBlack : Colors.grey.withOpacity(0.05),
              border:
                  Border.all(color: Colors.grey.withOpacity(0.5), width: 0.3),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Icon(Icons.timer_outlined, color: AppColors.kPrimary),
                SizedBox(width: 20.w),
                Text(
                  formattedTime,
                  style: AppTypography.kRegular16.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> selectTime(bool isStartTime) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(isStartTime ? startTime : endTime),
    );

    if (selectedTime != null) {
      DateTime selectedDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (!isStartTime && selectedDateTime.isBefore(startTime)) {
        showErrorDialog(
          'End time must be after start time.',
          'Invalid Time Range',
        );
        return; // Abort further processing
      }

      setState(() {
        if (isStartTime) {
          startTime = selectedDateTime;
        } else {
          endTime = selectedDateTime;
        }
      });

      widget.onTimeRangeChanged(startTime, endTime);
    }
  }
}
