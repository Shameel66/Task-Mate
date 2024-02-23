import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/controllers/auth_controller.dart';
import 'package:task_mate/app/model/task_model.dart';

class TaskController extends GetxController {
  final _taskList = Rx<List<TaskModel>?>([]);
  List<TaskModel>? get taskList => _taskList.value;

  final _taskDoneList = Rx<List<TaskModel>?>([]);
  List<TaskModel>? get taskDoneList => _taskDoneList.value;

  Stream<List<TaskModel>?> allTaskStream() {
    return FirebaseFirestore.instance
        .collection('task')
        .where('ownerId', isEqualTo: Get.find<AuthController>().user!.uid)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TaskModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<TaskModel>?> allDoneTaskStream() {
    return FirebaseFirestore.instance
        .collection('task')
        .where('ownerId', isEqualTo: Get.find<AuthController>().user!.uid)
        .where('selectedDate', isEqualTo: DateTime.now())
        .where('isDone', isEqualTo: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TaskModel.fromMap(doc.data());
      }).toList();
    });
  }

  @override
  void onInit() {
    _taskList.bindStream(allTaskStream());
    _taskDoneList.bindStream(allDoneTaskStream());
    super.onInit();
  }
}
