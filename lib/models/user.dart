class User {
  final String id;
  final String name;
  final String email;
  final bool isAdmin;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isAdmin': isAdmin ? 1 : 0,
    };
  }

  factory User.fromMap(Map<String, Object?> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      isAdmin: (map['isAdmin'] as int) == 1,
    );
  }
}
