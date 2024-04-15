import 'package:sa_2_guibrum/Utils/databaseHelper.dart';
import '../Model/User.dart';

class UserRepository {
  final dbHelper = DatabaseHelper();

  Future<void> addUser(User user) async {
    await dbHelper.insertUser(user);
  }

  Future<User?> getUser(String username, String password) async {
    return await dbHelper.getUser(username, password);
  }
}
