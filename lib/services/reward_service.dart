import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/reward_order.dart';

class RewardService {
  static Database? _database;
  static const String tableName = 'reward_orders';

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
      version: 2,  // เพิ่มเวอร์ชัน
      onCreate: (Database db, int version) async {
        print("Creating database tables...");
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            rewardId TEXT,
            name TEXT,
            points INTEGER,
            imagePath TEXT,
            firstName TEXT,
            lastName TEXT,
            phoneNumber TEXT,
            email TEXT,
            address TEXT,
            status TEXT,
            orderDate TEXT
          )
        ''');
        print("Tables created successfully!");
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        print("Upgrading database from v$oldVersion to v$newVersion");
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            rewardId TEXT,
            name TEXT,
            points INTEGER,
            imagePath TEXT,
            firstName TEXT,
            lastName TEXT,
            phoneNumber TEXT,
            email TEXT,
            address TEXT,
            status TEXT,
            orderDate TEXT
          )
        ''');
        print("Tables upgraded successfully!");
      },
    );
  }

  // เพิ่มฟังก์ชันตรวจสอบตาราง
  Future<void> ensureTableExists() async {
    final db = await database;
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'"
    );
    
    if (tables.isEmpty) {
      print("Table $tableName doesn't exist, creating it now...");
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          rewardId TEXT,
          name TEXT,
          points INTEGER,
          imagePath TEXT,
          firstName TEXT,
          lastName TEXT,
          phoneNumber TEXT,
          email TEXT,
          address TEXT,
          status TEXT,
          orderDate TEXT
        )
      ''');
      print("Table $tableName created successfully!");
    } else {
      print("Table $tableName exists!");
    }
  }

  Future<int> saveReward(RewardOrder reward) async {
    final db = await database;
    
    // ตรวจสอบว่าตารางมีอยู่หรือไม่ก่อนการบันทึก
    await ensureTableExists();
    
    print("Saving reward to database: ${reward.name}");
    return await db.insert(tableName, reward.toMap());
  }

  // ฟังก์ชันอื่นๆ คงเดิม...
Future<List<RewardOrder>> getRewards() async {
  try {
    final db = await database;
    
    // ตรวจสอบว่าตารางมีอยู่หรือไม่ก่อนการดึงข้อมูล
    await ensureTableExists();
    
    print("Fetching rewards from database...");
    final List<Map<String, dynamic>> maps = await db.query(
      tableName, 
      orderBy: 'orderDate DESC'
    );
    
    print("Found ${maps.length} rewards");
    return List.generate(maps.length, (i) {
      return RewardOrder.fromMap(maps[i]);
    });
  } catch (e) {
    print("Error fetching rewards: $e");
    // ส่งคืนรายการว่างในกรณีเกิดข้อผิดพลาด
    return [];
  }
}
}