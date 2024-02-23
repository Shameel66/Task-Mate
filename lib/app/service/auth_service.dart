import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/controllers/auth_controller.dart';
import 'package:task_mate/app/controllers/user_controller.dart';
import 'package:task_mate/app/data/error_handlers/firebase_auth_exceptions.dart';
import 'package:task_mate/app/model/user_model.dart';
import 'package:task_mate/app/modules/widgets/dialogs/error_dialog.dart';
import 'package:task_mate/app/modules/widgets/dialogs/loading_dialog.dart';
import 'package:task_mate/app/service/database_service.dart';

class AuthService {
  final db = DatabaseService();

  final _auth = FirebaseAuth.instance;
  AuthController get controller => Get.find<AuthController>();
  UserController get userController => Get.find<UserController>();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      showLoading();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _handleAuthStateLoader();
      hideLoading();
    } on TimeoutException {
      showLoading();

      showErrorDialog("Request Timed out", null);
    } on FirebaseAuthException catch (err) {
      hideLoading();

      showErrorDialog(AuthExceptionHandler.getError(err.code.toString()), null);
    }
  }

  void _handleAuthStateLoader() {
    Get.put(UserController(), permanent: true);
  }

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String emailAddress,
    required String password,
  }) async {
    showLoading();
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
      final user = UserModel(
          id: cred.user!.uid, name: name, email: emailAddress, profilePic: '');
      await db.userCollection.doc(cred.user!.uid).set(user);

      _handleAuthStateLoader();
      Get.back();
      hideLoading();
    } on FirebaseAuthException catch (e) {
      hideLoading();

      showErrorDialog(
          AuthExceptionHandler.getError(e.message.toString()), null);
      return;
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      showLoading();
      await _auth.sendPasswordResetEmail(email: email);

      Fluttertoast.showToast(
          msg: "Password Reset Email Sent", gravity: ToastGravity.BOTTOM);
      hideLoading();

      return true;
    } on FirebaseAuthException catch (e) {
      hideLoading();

      showErrorDialog(
          AuthExceptionHandler.getError(e.message.toString()), null);
      return false;
    }
  }

  Future<void> signOut() async {
    showLoading();
    await _auth.signOut();
    Get.delete<UserController>(force: true);
    hideLoading();
  }
}
