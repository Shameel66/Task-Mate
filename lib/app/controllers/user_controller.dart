import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/controllers/auth_controller.dart';
import 'package:task_mate/app/controllers/task_controller.dart';
import 'package:task_mate/app/model/user_model.dart';
import 'package:task_mate/app/service/database_service.dart';

class UserController extends GetxController {
  final authController = Get.find<AuthController>();
  final db = DatabaseService();
  //User Variable
  Rxn<UserModel> currentUser = Rxn<UserModel>();
  UserModel? get user => currentUser.value;
  String get currentUid => FirebaseAuth.instance.currentUser!.uid;

  DocumentReference get currentUserReference =>
      db.userCollection.doc(currentUid);
  Stream<UserModel?> get currentUserStream {
    return db.userCollection
        .doc(currentUid)
        .snapshots()
        .map((event) => event.data());
  }

  @override
  void onInit() {
    currentUser.bindStream(currentUserStream);

    super.onInit();
  }

  @override
  void onReady() {
    Get.put(TaskController(), permanent: true);

    super.onReady();
  }

  @override
  void onClose() {
    currentUser.close();
    Get.delete<TaskController>(force: true);
    super.onClose();
  }
}
