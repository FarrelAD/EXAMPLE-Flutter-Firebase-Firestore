class User {
  final String name, gender, hobby;
  final int age;

  User({
    required this.name,
    required this.gender,
    required this.hobby,
    required this.age
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "gender": gender,
      "hobby": hobby,
      "age": age
    };
  }
}
