import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'shopping_list.db';
  static const String tableName = 'items';

  // Método para inicializar o banco de dados
  static Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER, price REAL, selectedCurrency TEXT, bought INTEGER)',
        );
      },
      version: 1,
    );
  }

  // Método para obter o banco de dados
  static Database get database {
    if (_database == null) {
      initDatabase();
    }
    return _database!;
  }

  // Exemplo de método para inserir um item no banco de dados
  static Future<void> insertItem(Map<String, dynamic> itemData) async {
    final db = database;
    await db.insert(tableName, itemData, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Outros métodos CRUD podem ser adicionados conforme necessário
}
