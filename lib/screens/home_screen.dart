import 'package:flutter/material.dart';
import 'package:flutter_firebase_firestore/models/user.dart';
import 'package:flutter_firebase_firestore/repository/user_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserRepository _userRepository = UserRepository();
  late Future<List<User>> _userData;

  @override
  void initState() {
    super.initState();
    setState(() {
      _userData = Future.value([]);
    });
  }

  _getUserData() {
    setState(() {
      _userData = _userRepository.getAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Firebase Firestore Demo"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: _getUserData,
                  child: Text("Get data from Firestore!")),
              SizedBox(height: 50),
              FutureBuilder(
                  future: _userData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("No users found"));
                    }

                    List<User> users = snapshot.data!;

                    return _userContent(users);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _userContent(List<User> users) {
    return Expanded(
        child: ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        var user = users[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.cake, size: 20, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      "Age: ${user.age}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.interests, size: 20, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      "Hobby: ${user.hobby}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      user.gender == "male" 
                      ? Icons.male 
                      : Icons.female, 
                      size: 20, 
                      color: Colors.grey
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Gender: ${user.gender}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
