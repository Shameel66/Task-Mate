import 'dart:convert';

import 'package:task_mate/app/data/enums/task_priority.dart';

class TaskModel {
  String id;
  String ownerId;
  DateTime selectedDate;
  String taskName;
  String taskDescription;
  DateTime startTime;
  DateTime endTime;
  TaskPriority priority;
  bool isDone;

  TaskModel({
    required this.id,
    required this.ownerId,
    required this.selectedDate,
    required this.taskName,
    required this.taskDescription,
    required this.startTime,
    required this.endTime,
    required this.priority,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'selectedDate': selectedDate.toIso8601String(),
      'taskName': taskName,
      'taskDescription': taskDescription,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'priority': priority.name,
      'isDone': isDone,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      ownerId: map['ownerId'] ?? '',
      selectedDate: DateTime.parse(map['selectedDate'] ?? ''),
      taskName: map['taskName'] ?? '',
      taskDescription: map['taskDescription'] ?? '',
      startTime: DateTime.parse(map['startTime'] ?? ''),
      endTime: DateTime.parse(map['endTime'] ?? ''),
      priority: TaskPriority.values.byName(map['priority']),
      isDone: map['isDone'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
     TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

