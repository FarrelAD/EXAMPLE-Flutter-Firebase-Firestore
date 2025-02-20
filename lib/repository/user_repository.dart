import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection("users").get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}