import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'user_model.dart';

class DatabaseHelper {
  static final _databaseName = "UserDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'users';

  static final columnId = 'id';
  static final columnUsername = 'username';
  static final columnPassword = 'password';

  // torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // possui apenas uma referência de banco de dados
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // inicializa o banco de dados
    _database = await _initDatabase();
    return _database!;
  }

  // abre o banco de dados se já existe, caso contrário, cria um novo
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // cria a tabela 'users' se ela não existir
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnUsername TEXT NOT NULL,
        $columnPassword TEXT NOT NULL
      )
      ''');
  }

  // insere um novo usuário no banco de dados
  Future<int> insert(UserModel user) async {
    Database db = await instance.database;
    return await db.insert(table, user.toMap());
  }

  // obtém um usuário pelo nome de usuário
  Future<UserModel?> getUser(String username) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      table,
      columns: [columnId, columnUsername, columnPassword],
      where: '$columnUsername = ?',
      whereArgs: [username],
    );
    if (maps.length > 0) {
      return UserModel(
        id: maps[0][columnId],
        username: maps[0][columnUsername],
        password: maps[0][columnPassword],
      );
    }
    return null;
  }
}