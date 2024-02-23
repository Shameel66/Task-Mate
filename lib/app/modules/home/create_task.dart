import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/controllers/task_controller.dart';
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/data/enums/task_priority.dart';
import 'package:task_mate/app/model/task_model.dart';
import 'package:task_mate/app/modules/home/components/custom_calendar.dart';
import 'package:task_mate/app/modules/home/components/custom_textfield.dart';
import 'package:task_mate/app/modules/home/components/task_priorit_button.dart';
import 'package:task_mate/app/modules/home/components/time_range_widget.dart';
import 'package:task_mate/app/modules/widgets/buttons/primary_button.dart';
import 'package:task_mate/app/repo/task_repo.dart';

class CreateTaskPage extends StatefulWidget {
  final TaskModel? task;
  final bool isEdit;
  const CreateTaskPage({super.key, this.task, this.isEdit = false});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime taskDate = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TaskPriority selectedPriority = TaskPriority.medium;
  final TaskRepo _taskRepo = TaskRepo();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      nameController.text = widget.task!.taskName;
      descriptionController.text = widget.task!.taskDescription;
      taskDate = widget.task!.selectedDate;
      startDate = widget.task!.startTime;
      endDate = widget.task!.endTime;
      selectedPriority = widget.task!.priority;
      print(taskDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('Create New Task'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCalendar(
                focusDate: taskDate,
                onDateChange: (date) {
                  setState(() {
                    taskDate = date;
                  });
                },
              ),
              SizedBox(height: 30.h),
              Text('Schedule', style: AppTypography.kRegular22),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: nameController,
                hintText: 'Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter task name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                controller: descriptionController,
                hintText: 'Description',
                maxLines: 5,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter task description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.h),
              TimeRangeWidget(
                  initialStartTime: startDate,
                  initialEndTime: endDate,
                  onTimeRangeChanged: (start, end) {
                    setState(() {
                      startDate = start;
                      endDate = end;
                    });
                  }),
              SizedBox(height: 30.h),
              Text('Priority', style: AppTypography.kRegular16),
              SizedBox(height: 10.h),
              PriorityButtons(
                initialPriority: selectedPriority,
                onSelect: (priority) {
                  setState(() {
                    selectedPriority = priority!;
                  });
                  print(priority);
                },
              ),
              SizedBox(height: 50.h),
              if (widget.isEdit) ...[
                Row(
                  children: [
                    Expanded(
                        child: PrimaryButton(
                      onTap: () {
                        _taskRepo.deleteTask(widget.task!);
                      },
                      borderColor: AppColors.kPrimary,
                      textColor: AppColors.kPrimary,
                      text: 'Delete',
                      isBorder: true,
                      color: Colors.transparent,
                    )),
                    SizedBox(width: 20.w),
                    Expanded(
                        child: PrimaryButton(
                            onTap: () {
                              _taskRepo.updateTask(TaskModel(
                                  id: widget.task!.id,
                                  ownerId: widget.task!.ownerId,
                                  selectedDate: taskDate,
                                  taskName: nameController.text,
                                  taskDescription: descriptionController.text,
                                  startTime: startDate,
                                  endTime: endDate,
                                  priority: selectedPriority,
                                  isDone: false));
                              Get.find<TaskController>().update();
                            },
                            text: 'Edit')),
                  ],
                ),
              ] else ...[
                PrimaryButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await _taskRepo.addTask(TaskModel(
                            id: '',
                            ownerId: '',
                            selectedDate: taskDate,
                            taskName: nameController.text,
                            taskDescription: descriptionController.text,
                            startTime: startDate,
                            endTime: endDate,
                            priority: selectedPriority,
                            isDone: false));
                      }
                    },
                    text: 'Create Task'),
                SizedBox(height: 20.h),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
