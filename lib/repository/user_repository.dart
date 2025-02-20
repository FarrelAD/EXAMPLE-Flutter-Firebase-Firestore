import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_firestore/models/user.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<User>> getAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection("users").get();

    return snapshot.docs
      .map((doc) => User.fromMap(doc.data()))
      .toList();
  }
}