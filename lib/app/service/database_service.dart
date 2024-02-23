import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_mate/app/model/task_model.dart';
import 'package:task_mate/app/model/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? get cUid => FirebaseAuth.instance.currentUser?.uid;
  CollectionReference get _usersCollection => _firestore.collection('users');
  CollectionReference<UserModel?> get userCollection =>
      _usersCollection.withConverter(fromFirestore: (snapshot, options) {
        return snapshot.exists ? UserModel.fromMap(snapshot.data()!) : null;
      }, toFirestore: (object, options) {
        return object!.toMap();
      });

  CollectionReference<TaskModel> get taskCollection =>
      _firestore.collection('task').withConverter<TaskModel>(
            fromFirestore: (snapshot, _) => TaskModel.fromMap(snapshot.data()!),
            toFirestore: (object, _) => object.toMap(),
          );
}
