import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pantone_book/model/pantone_model.dart';

import '../../model/trendy_color_model.dart';
import '../../model/week_banner_model.dart';

class AppDb {
  static final AppDb instance = AppDb._init();

  static Database? _database;

  AppDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pantone_colors.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE pantone_colors ( 
      id $idType, 
      pantone_code $textType,
      color_name $textType,
      red $intType,
      green $intType,
      blue $intType
    )
    ''');


    await db.execute('''
    CREATE TABLE week_banner (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      colorName TEXT,
      tcxCode TEXT,
      tcxColorR INTEGER,
      tcxColorG INTEGER,
      tcxColorB INTEGER,
      bannerColorR INTEGER,
      bannerColorG INTEGER,
      bannerColorB INTEGER,
      bannerFontColorR INTEGER,
      bannerFontColorG INTEGER,
      bannerFontColorB INTEGER,
      tcxFontColorR INTEGER,
      tcxFontColorG INTEGER,
      tcxFontColorB INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE trendy_color (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      colorName TEXT,
      tcxCode TEXT,
      cardColorR INTEGER,
      cardColorG INTEGER,
      cardColorB INTEGER,
      fontColorR INTEGER,
      fontColorG INTEGER,
      fontColorB INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE trendy_text (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      trendyText TEXT
    )
    ''');
  }

  //Pantone DB

  Future<int> insertPantoneColor(PantoneColor pantoneColor) async {
    final db = await instance.database;
    return await db.insert('pantone_colors', pantoneColor.toMap());
  }

  Future<List<PantoneColor>> fetchAllPantoneColors() async {
    final db = await instance.database;
    final result = await db.query('pantone_colors');
    return result.map((map) => PantoneColor.fromMap(map)).toList();
  }

  Future<PantoneColor?> fetchPantoneColorById(int id) async {
    final db = await instance.database;
    final result = await db.query('pantone_colors', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return PantoneColor.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<bool> isDatabaseLoaded() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM pantone_colors');
    int count = Sqflite.firstIntValue(result)!;

    return count > 0; // Returns true if data exists, false if empty
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  //Week Banner DB

  Future<void> insertWeekBanner(WeekBannerModel banner) async {
    final db = await database;
    await db.insert('week_banner', banner.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> clearWeekBannerTable() async {
    final db = await database;

    // Check if the table exists
    final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='week_banner';"
    );

    // If the table exists, delete its contents
    if (result.isNotEmpty) {
      await db.delete('week_banner');
    }
  }

  Future<List<WeekBannerModel>> getWeekBanners() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('week_banner');
    return maps.map((map) => WeekBannerModel.fromMap(map)).toList();
  }

  // CRUD operations for TrendyColorModel
  Future<void> insertTrendyColor(TrendyColorModel color) async {
    final db = await database;
    await db.insert('trendy_color', color.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TrendyColorModel>> getTrendyColors() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('trendy_color');
    return maps.map((map) => TrendyColorModel.fromMap(map)).toList();
  }

  Future<void> clearTrendyColorTable() async {
    final db = await database;

    // Check if the table exists
    final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='trendy_color';"
    );

    // If the table exists, delete its contents
    if (result.isNotEmpty) {
      await db.delete('trendy_color');
    }
  }

  //TRENDY TEXT
  Future<void> insertTrendyText(String text) async {
    final db = await database;
    await db.insert('trendy_text', {
      'trendyText': text,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String> getTrendyText() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('trendy_text');
    String text = maps.first['trendyText'];
    return text;
  }

  Future<void> clearTrendyTextTable() async {
    final db = await database;

    // Check if the table exists
    final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='trendy_text';"
    );

    // If the table exists, delete its contents
    if (result.isNotEmpty) {
      await db.delete('trendy_text');
    }
  }
}
