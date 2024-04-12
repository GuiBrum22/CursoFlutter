import 'package:sa_2_guibrum/Utils/databaseHelper.dart'; // Importação da classe DatabaseHelper
import '../Model/User.dart'; // Importação da classe User

// Definição da classe UserRepository
class UserRepository {
  final dbHelper = DatabaseHelper(); // Instância da classe DatabaseHelper

  // Método para adicionar um usuário ao banco de dados
  Future<void> addUser(User user) async {
    await dbHelper.insertUser(user); // Chama o método insertUser da classe DatabaseHelper
  }

  // Método para obter um usuário do banco de dados com base no nome de usuário e senha
  Future<User?> getUser(String username, String password) async {
    return await dbHelper.getUser(username, password); // Chama o método getUser da classe DatabaseHelper
  }
}
