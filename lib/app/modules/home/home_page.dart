import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:task_mate/app/controllers/task_controller.dart';
import 'package:task_mate/app/data/constants/app_color.dart';
import 'package:task_mate/app/data/constants/app_typography.dart';
import 'package:task_mate/app/model/task_model.dart';
import 'package:task_mate/app/modules/home/components/daily_card.dart';
import 'package:task_mate/app/modules/home/components/search_field.dart';
import 'package:task_mate/app/modules/home/components/task_card.dart';
import 'package:task_mate/app/modules/home/create_task.dart';
import 'package:task_mate/app/modules/profile/components/avatar.dart';
import 'package:task_mate/app/modules/profile/profile_page.dart';
import 'package:task_mate/app/modules/widgets/animation/fade_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  TaskController tc = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'You have got 5 tasks\ntoday to complete',
                  style: AppTypography.kSemiBold20,
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(() => const SettingPage());
                    },
                    child: ProfileImageWidget(
                      radius: 25.r,
                    ))
              ],
            ),
            SizedBox(height: 20.h),
            // Search Field
            SearchField(
              controller: _searchController,
              onChanged: (value)=>tc.searchTasks(value),
            ),
            SizedBox(height: 20.h),
            // Daily Progress

            Obx(() {
              if (tc.taskList == null || tc.taskList!.isEmpty) {
                return const SizedBox();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Progress', style: AppTypography.kRegular22),
                  SizedBox(height: 10.h),
                  DailyCard(
                      doneTask: tc.taskDoneList!.length,
                      totalTask: tc.taskList!.length),
                ],
              );
            }),
            SizedBox(height: 30.h),

            Obx(() {
              List<TaskModel> taskList = _searchController.text.isNotEmpty
                  ? tc.searchedTaskList ?? []
                  : tc.taskList ?? [];

              if (taskList.isEmpty) {
                return Center(
                  child:
                      Lottie.asset('assets/lottie/empty.json', repeat: false),
                );
              }

              Map<String, List<TaskModel>> groupedTasks =
                  groupTasksByDate(taskList);
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: groupedTasks.length,
                  itemBuilder: (context, index) {
                    String date = groupedTasks.keys.elementAt(index);
                    List<TaskModel> tasksForDate = groupedTasks[date]!;
                    Duration duration =
                        Duration(milliseconds: 700 + (100 * index));
                    return FadeInAnimation(
                      duration: duration,
                      curve: Curves.easeOut,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getHeading(date), style: AppTypography.kBold18),
                          SizedBox(height: 5.h),
                          ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10.h),
                            itemCount: tasksForDate.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return TaskCard(
                                task: tasksForDate[index],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CreateTaskPage());
        },
        backgroundColor: AppColors.kPrimary,
        child: Icon(Icons.add, color: AppColors.kWhite),
      ),
    );
  }

  Map<String, List<TaskModel>> groupTasksByDate(List<TaskModel> tasks) {
    Map<String, List<TaskModel>> groupedTasks = {};

    tasks.sort((a, b) => a.selectedDate.compareTo(b.selectedDate));

    for (TaskModel task in tasks) {
      String date = DateFormat('dd MMM, yyyy').format(task.selectedDate);
      if (isToday(task.selectedDate)) {
        date = 'Today';
      }

      if (groupedTasks.containsKey(date)) {
        groupedTasks[date]!.add(task);
      } else {
        groupedTasks[date] = [task];
      }
    }

    return groupedTasks;
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  String getHeading(String date) {
    return isTodayHeading(date) ? 'Today' : date;
  }

  bool isTodayHeading(String date) {
    return date.toLowerCase() == 'today';
  }
}
