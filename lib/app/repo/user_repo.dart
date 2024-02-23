import 'dart:io';

import 'package:get/get.dart';
import 'package:task_mate/app/controllers/user_controller.dart';
import 'package:task_mate/app/modules/widgets/dialogs/error_dialog.dart';
import 'package:task_mate/app/modules/widgets/dialogs/loading_dialog.dart';
import 'package:task_mate/app/service/database_service.dart';
import 'package:task_mate/app/service/firebase_storage_services.dart';

class UserRepo {
  final _db = DatabaseService();
  String get _currentUid => Get.find<UserController>().currentUid;

  Future<void> updateName(String name) async {
    showLoading();
    try {
      await _db.userCollection.doc(_currentUid).update({'name': name});
      hideLoading();
    } catch (e) {
      hideLoading();
      showErrorDialog(e.toString(), null);
    }
  }

  Future<void> updateProfilePhoto({required File photo}) async {
    showLoading();
    try {
      final url = await FirebaseStorageServices.uploadToStorage(
        file: photo,
        showDialog: false,
        folderName: StorageFolderNames.userFolder(_currentUid),
      );
      await _db.userCollection.doc(_currentUid).update({'profilePic': url});
      hideLoading();
    } catch (e) {
      hideLoading();
      showErrorDialog(e.toString(), null);
    }
  }
}
