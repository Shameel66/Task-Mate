import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:task_mate/app/controllers/task_controller.dart';
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/data/enums/task_priority.dart';
import 'package:task_mate/app/data/helpers/date_utils.dart';
import 'package:task_mate/app/model/task_model.dart';
import 'package:task_mate/app/modules/home/create_task.dart';
import 'package:task_mate/app/repo/task_repo.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    print(widget.task.isDone);
    return GestureDetector(
      onTap: () {
        Get.to(() => CreateTaskPage(task: widget.task, isEdit: true));
      },
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 10.w,
              decoration: BoxDecoration(
                  color: widget.task.priority == TaskPriority.high
                      ? AppColors.kHighColor
                      : widget.task.priority == TaskPriority.medium
                          ? AppColors.kMediumColor
                          : AppColors.kLowColor,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(9.r))),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(9.r)),
                    color: Colors.grey.withOpacity(0.1)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.task.taskName,
                            style: AppTypography.kRegular16,
                          ),
                          Text(
                            widget.task.taskDescription,
                            style: AppTypography.kLight14,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month, size: 15),
                              SizedBox(width: 5.w),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  DateUtilsClass.formatDateTime(
                                      widget.task.selectedDate),
                                  style: AppTypography.kRegular14,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Start Time: ${DateUtilsClass.formatTime(widget.task.startTime)} - End Time: ${DateUtilsClass.formatTime(widget.task.endTime)}',
                            style:
                                AppTypography.kLight14.copyWith(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    MSHCheckbox(
                      size: 30,
                      value: widget.task.isDone,
                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                        checkedColor: AppColors.kPrimary,
                      ),
                      style: MSHCheckboxStyle.fillScaleCheck,
                      onChanged: (selected) {
                        setState(() {
                          isChecked = selected;
                        });

                        TaskRepo().updateTaskIsDone(widget.task, isChecked);
                        Get.find<TaskController>().update();
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
