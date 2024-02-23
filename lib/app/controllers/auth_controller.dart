import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value;

  bool get isProperlyAuthenticated => user != null && !user!.isAnonymous;
  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());

    super.onInit();
  }
}
