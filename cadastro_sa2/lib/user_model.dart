class UserModel {
  final int id;
  final String username;
  final String password;

  UserModel({
    required this.id,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }
}