import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LivroDB {
  static final LivroDB _instance = new LivroDB.getInstance();

  factory LivroDB() => _instance;

  LivroDB.getInstance();

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'livro.db');

    var db = await openDatabase(path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
   await lerArquivoAssets(db, 'assets/sql/create.sql');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await lerArquivoAssets(db, 'assets/sql/update_1.sql');
  }

  lerArquivoAssets(Database db, String script) async {
    String table = await rootBundle.loadString(script);

    var scripts = table.split(';');

    for(String sql in scripts) {
      sql = sql.replaceAll(new RegExp(r"\n"), "");

      if (sql.trim().isNotEmpty) {
        print('sql: $sql');
        db.execute(sql);
      }
    }

  }
}
