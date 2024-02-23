import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/data/constants/app_color.dart';
import 'package:task_mate/app/data/constants/app_typography.dart';
import 'package:task_mate/app/data/enums/task_priority.dart';

class PriorityButtons extends StatefulWidget {
  final Function(TaskPriority?) onSelect;
  final TaskPriority? initialPriority;
  const PriorityButtons(
      {super.key, required this.onSelect, this.initialPriority});

  @override
  State<PriorityButtons> createState() => _PriorityButtonsState();
}

class _PriorityButtonsState extends State<PriorityButtons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorTween;
  TaskPriority? priority;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _colorTween = _controller.drive(
      ColorTween(
        begin: null,
        end: AppColors.kHighColor,
      ),
    );

    priority = widget.initialPriority;

    if (priority == null) {
      priority = TaskPriority.medium;
      _animateColor(AppColors.kMediumColor);
    } else {
      _animateColor(
        priority == TaskPriority.high
            ? AppColors.kHighColor
            : priority == TaskPriority.medium
                ? AppColors.kMediumColor
                : AppColors.kLowColor,
      );
    }

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant PriorityButtons oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialPriority != oldWidget.initialPriority) {
      priority = widget.initialPriority;
      _animateColor(widget.initialPriority == TaskPriority.high
          ? AppColors.kHighColor
          : widget.initialPriority == TaskPriority.medium
              ? AppColors.kMediumColor
              : AppColors.kLowColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        _priorityButton(
            onTap: () {
              setState(() {
                priority = TaskPriority.high;
              });
              _animateColor(AppColors.kHighColor);
              widget.onSelect(priority);
            },
            isDarkMode: isDarkMode(context),
            color: AppColors.kHighColor,
            isSelected: priority == TaskPriority.high,
            text: TaskPriority.high.name.capitalizeFirst.toString()),
        SizedBox(width: 10.w),
        _priorityButton(
            onTap: () {
              setState(() {
                priority = TaskPriority.medium;
              });
              _animateColor(AppColors.kMediumColor);
              widget.onSelect(priority);
            },
            isDarkMode: isDarkMode(context),
            color: AppColors.kMediumColor,
            isSelected: priority == TaskPriority.medium,
            text: TaskPriority.medium.name.capitalizeFirst.toString()),
        SizedBox(width: 10.w),
        _priorityButton(
            onTap: () {
              setState(() {
                priority = TaskPriority.low;
              });
              _animateColor(AppColors.kLowColor);
              widget.onSelect(priority);
            },
            isDarkMode: isDarkMode(context),
            color: AppColors.kLowColor,
            isSelected: priority == TaskPriority.low,
            text: TaskPriority.low.name.capitalizeFirst.toString()),
      ],
    );
  }

  Widget _priorityButton(
      {required VoidCallback onTap,
      required String text,
      required bool isSelected,
      required Color color,
      required bool isDarkMode}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedBuilder(
          animation: _colorTween,
          builder: (context, child) {
            return Container(
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: color),
                color: isSelected
                    ? _colorTween.value
                    : Colors.grey.withOpacity(0.1),
              ),
              child: Text(text, style: AppTypography.kRegular16),
            );
          },
        ),
      ),
    );
  }

  void _animateColor(Color newColor) {
    _controller.reset();
    _controller.forward();
    _colorTween = _controller.drive(
      ColorTween(
        begin: _colorTween.value ?? AppColors.kBlack,
        end: newColor,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
