import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{

  static Future<Database> _openDatabase() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'database.db');
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  static Future<void> _createDatabase(Database db, int version) async{
    await db.execute('''
      CREATE TABLE IF NOT EXISTS good (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        comment TEXT,
        days INTEGER,
        actions INTEGER,
        color TEXT,
        icon TEXT,
        date TEXT
      )
    ''');
  }

  static Future<int> insertUser(String name, String comment, int days, int actions, String color, String icon) async{
    final db = await _openDatabase();
    final data = {
      'name' : name,
      'comment' : comment,
      'days' : days,
      'actions' : actions,
      'color' : color,
      'icon' : icon,
      'date' : DateTime.now().toString(),
    };
    return await db.insert('good', data);
  }

  static Future<List<Map<String, dynamic>>> getData()async {
    final db = await _openDatabase();
    return await db.query('good');
  }

  static Future<int> deleteData(int id) async{
    final db = await _openDatabase();
    return await db.delete('good', where: 'id = ?', whereArgs: [id]);
  }

  static Future<Map<String, dynamic>?> getSingleData(int id) async{
    final db = await _openDatabase();
    List<Map<String, dynamic>> result = await db.query(
      'good',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  static Future<int> updateData(int id, Map<String, dynamic> data) async{
    final db = await _openDatabase();
    return await db.update('good', data, where: 'id = ?', whereArgs: [id]);
  }

}