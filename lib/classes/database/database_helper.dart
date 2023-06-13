import 'package:molkky_match/utils/imports.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static Future<sql.Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final dbFile = path.join(dbPath, 'molkky_match.db');

    return sql.openDatabase(
      dbFile,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE players(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            name TEXT,
            createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            updatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
          )
        """);
      },
    );
  }

  static Future<int> createPlayer(Player player) async {
    final db = await _getDatabase();

    final data = player.toMap();
    final id = await db.insert('players', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Player>> getPlayers() async {
    final db = await _getDatabase();
    final results = await db.query('players', orderBy: "name");
    return results.map((data) => Player.fromMap(data)).toList();
  }

  static Future<Player?> getPlayer(int id) async {
    final db = await _getDatabase();
    final results = await db.query('players', where: "id = ?", whereArgs: [id], limit: 1);

    if (results.isNotEmpty) {
      return Player.fromMap(results.first);
    }

    return null;
  }

  static Future<int> updatePlayer(Player player) async {
    final db = await _getDatabase();

    final data = {
      'name': player.name,
      'updatedAt': DateTime.now().toIso8601String(),
    };

    final result = await db.update('players', data, where: "id = ?", whereArgs: [player.id]);
    return result;
  }

  static Future<void> deletePlayer(int id) async {
    final db = await _getDatabase();
    try {
      await db.delete("players", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}