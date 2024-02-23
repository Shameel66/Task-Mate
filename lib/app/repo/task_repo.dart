import 'package:get/get.dart';
import 'package:task_mate/app/controllers/auth_controller.dart';
import 'package:task_mate/app/model/task_model.dart';
import 'package:task_mate/app/modules/widgets/dialogs/error_dialog.dart';
import 'package:task_mate/app/modules/widgets/dialogs/loading_dialog.dart';
import 'package:task_mate/app/service/database_service.dart';

class TaskRepo {
  var db = DatabaseService();

  Future<void> addTask(TaskModel task) async {
    try {
      showLoading();
      var doc = db.taskCollection.doc();
      task.id = doc.id;
      task.ownerId = Get.find<AuthController>().user!.uid;
      await doc.set(task);
      hideLoading();
      Get.back();
    } catch (e) {
      hideLoading();
      showErrorDialog(e.toString(), null);
    }
  }

  Future<void> updateTaskIsDone(TaskModel task, bool isDone) async {
    try {
      showLoading();
      var currentUserUid = Get.find<AuthController>().user!.uid;

      if (task.ownerId == currentUserUid) {
        await db.taskCollection.doc(task.id).update({'isDone': isDone});
      } else {
        hideLoading();
        showErrorDialog(
            'You do not have permission to update this task.', null);
        return;
      }

      hideLoading();
    } catch (e) {
      hideLoading();
      showErrorDialog(e.toString(), null);
    }
  }

  Future<void> updateTask(TaskModel task) async {
  try {
    showLoading();
    var currentUserUid = Get.find<AuthController>().user!.uid;

    if (task.ownerId == currentUserUid) {
      await db.taskCollection.doc(task.id).update(task.toMap());
    } else {
      hideLoading();
      showErrorDialog(
          'You do not have permission to update this task.', null);
      return;
    }

    hideLoading();
    Get.back(); // This will navigate back to the previous screen
  } catch (e) {
    hideLoading();
    showErrorDialog(e.toString(), null);
  }
}

  Future<void> deleteTask(TaskModel task) async {
    try {
      showLoading();
      var currentUserUid = Get.find<AuthController>().user!.uid;

      if (task.ownerId == currentUserUid) {
        await db.taskCollection.doc(task.id).delete();
      } else {
        hideLoading();
        showErrorDialog(
            'You do not have permission to delete this task.', null);
        return;
      }

      hideLoading();
      Get.back();
    } catch (e) {
      hideLoading();
      showErrorDialog(e.toString(), null);
    }
  }
}
