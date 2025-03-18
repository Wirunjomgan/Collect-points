import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PointService {
  static Database? _database;
  static const String tableName = 'user_points';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), 'vava_rewards.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            points INTEGER
          )
        ''');
        
        // Insert default points on first run
        await db.insert(tableName, {'points': 2034});
      },
    );
  }

  Future<int?> getUserPoints() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    
    if (result.isNotEmpty) {
      return result.first['points'];
    }
    
    // If no points record exists, create one with default value
    await db.insert(tableName, {'points': 2034});
    return 2034;
  }

  Future<void> updatePoints(int newPoints) async {
    final db = await database;
    
    // Check if points record exists
    final List<Map<String, dynamic>> result = await db.query(tableName);
    
    if (result.isEmpty) {
      // Insert if no record exists
      await db.insert(tableName, {'points': newPoints});
    } else {
      // Update existing record
      await db.update(
        tableName,
        {'points': newPoints},
        where: 'id = ?',
        whereArgs: [result.first['id']],
      );
    }
  }
}