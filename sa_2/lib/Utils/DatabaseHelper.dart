import 'package:sa_2_guibrum/Model/User.dart'; // Importa a classe User
import 'package:sqflite/sqflite.dart'; // Importa o pacote sqflite para trabalhar com o SQLite
import 'package:path/path.dart'; // Importa o pacote path para manipular caminhos de arquivos

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal() {
    initDb(); // Chama o método para inicializar o banco de dados
  }

  late Database _db; // Declaração da instância do banco de dados

  Future<void> initDb() async {
    final path = await getDatabasesPath(); // Obtém o caminho do diretório de bancos de dados
    final databasePath = join(path, 'authentication.db'); // Concatena o caminho com o nome do banco de dados

    _db = await openDatabase( // Abre o banco de dados
      databasePath,
      version: 1, // Versão do banco de dados
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS users(
            username TEXT PRIMARY KEY,
            password TEXT
          )
        '''); // Cria a tabela "users" se ela não existir
      },
    );
  }

  Future<int> insertUser(User user) async {
    await initDb(); // Inicializa o banco de dados
    final dbClient = _db; // Obtém a instância do banco de dados
    return await dbClient.insert('users', user.toMap()); // Insere um usuário na tabela "users"
  }

  Future<User?> getUser(String username, String password) async {
    await initDb(); // Inicializa o banco de dados
    final dbClient = _db; // Obtém a instância do banco de dados
    final List<Map<String, dynamic>> maps = await dbClient.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    ); // Realiza uma consulta na tabela "users" buscando um usuário com o nome de usuário e senha fornecidos

    if (maps.isEmpty) return null; // Retorna null se a lista de resultados estiver vazia
    return User.fromMap(maps.first); // Retorna o primeiro usuário encontrado na lista de resultados
  }

  Future<int> deleteUser(String username) async {
    print('Chamado deleteUser com username: $username'); // Exibe uma mensagem de depuração
    await initDb(); // Inicializa o banco de dados
    final dbClient = _db; // Obtém a instância do banco de dados
    final rowsDeleted = await dbClient.delete(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    ); // Deleta um usuário da tabela "users" com o nome de usuário fornecido

    print('Registros excluídos: $rowsDeleted'); // Exibe a quantidade de registros excluídos
    return rowsDeleted; // Retorna a quantidade de registros excluídos
  }
}
