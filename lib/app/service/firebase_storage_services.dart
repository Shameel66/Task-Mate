// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:task_mate/app/modules/widgets/dialogs/error_dialog.dart';
import 'package:task_mate/app/modules/widgets/dialogs/loading_dialog.dart';

class FirebaseStorageServices {
  static Future<String> uploadToStorage(
      {required File file,
      required String folderName,
      bool showDialog = true}) async {
    showDialog ? showLoading() : null;
    try {
      final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
            '$folderName/file${DateTime.now().millisecondsSinceEpoch}',
          );

      final UploadTask uploadTask = firebaseStorageRef.putFile(file);

      final TaskSnapshot downloadUrl = await uploadTask;

      String url = await downloadUrl.ref.getDownloadURL();
      showDialog ? hideLoading() : null;
      return url;
    } on Exception catch (e) {
      showDialog ? hideLoading() : null;
      showErrorDialog(e.toString(), null);
      return "";
    }
  }
}

class StorageFolderNames {
  static String userFolder(String uid) => 'Users/$uid';
}
