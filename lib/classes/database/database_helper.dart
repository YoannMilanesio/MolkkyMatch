import 'package:molkky_match/utils/imports.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE players(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a player
// title: the name of a player

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'molkky_match.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new player
  static Future<int> createPlayer(String? name) async {
    final db = await DatabaseHelper.db();

    final data = {'name': name};
    final id = await db.insert('players', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all players
  static Future<List<Map<String, dynamic>>> getPlayers() async {
    final db = await DatabaseHelper.db();
    return db.query('players', orderBy: "id");
  }

  // Get a single player by id
  static Future<List<Map<String, dynamic>>> getPlayer(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('players', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update a player by id
  static Future<int> updatePlayer(
      int id, String name) async {
    final db = await DatabaseHelper.db();

    final data = {
      'name': name,
      'updatedAt': DateTime.now().toString()
    };

    final result = await db.update('players', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete a player by id
  static Future<void> deletePlayer(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("players", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}