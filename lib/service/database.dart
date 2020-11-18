import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:wallet/wallet.dart';

class Database extends GetxService {
  Database._(sqflite.Database db) : _db = db;
  final sqflite.Database _db;

  static Future<Database> init() async {
    final db = await sqflite.openDatabase(
      'edgeware_wallet.db',
      onCreate: _DbSchema.onCreate,
      onUpgrade: _DbSchema.onUpgrade,
      version: 1,
    );
    return Database._(db);
  }

  sqflite.Database get instance => _db;

  @override
  Future<void> onClose() async {
    await _db.close();
  }
}

class _DbSchema {
  static Future<void> onCreate(sqflite.Database db, int version) async {
    // Tables
    await Future.wait([
      db.execute(kContactsTable),
    ]);
    // Triggers
    await Future.wait([
      db.execute(kContactsUpdatedAtTrigger),
    ]);
  }

  static Future<void> onUpgrade(
    sqflite.Database db,
    int oldVersion,
    int newVersion,
  ) async {
    // No Updates for now.
    return;
  }

  static const String kContactsTable = '''
  CREATE TABLE IF NOT EXISTS ${TableNames.contacts} (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    address TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
  );
  ''';

  static const String kContactsUpdatedAtTrigger = '''
  CREATE TRIGGER tg_${TableNames.contacts}_updated_at
  AFTER UPDATE ON ${TableNames.contacts} FOR EACH ROW
  BEGIN
    UPDATE ${TableNames.contacts}
    SET updated_at = CURRENT_TIMESTAMP
    WHERE id = old.id;
  END;
  ''';
}
