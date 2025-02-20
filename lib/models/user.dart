class User {
  final String name, gender, hobby;
  final int age;

  User({
    required this.name,
    required this.gender,
    required this.hobby,
    required this.age
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? 'No Name',
      age: map['age'] ?? 0,
      hobby: map['hobby'] ?? 'Not specified',
      gender: map['gender'] ?? 'Not specified',
    );
  }
}
