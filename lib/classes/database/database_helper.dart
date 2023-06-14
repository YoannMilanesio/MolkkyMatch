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

        await db.execute('''
          CREATE TABLE matches (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            teams TEXT,
            scores TEXT
          )
        ''');
      },
    );
  }

  /*static Future<int> createMatch(List<Player> team1Players, List<Player> team2Players) async {
    final db = await _getDatabase();

    final formattedDate = DateTime.now().toIso8601String();

    final team1PlayerNames = team1Players.map((player) => player.name).join(',');
    final team2PlayerNames = team2Players.map((player) => player.name).join(',');

    final match = {
      'date': formattedDate,
      'team1': team1PlayerNames,
      'team2': team2PlayerNames,
    };

    final id = await db.insert('matches', match);

    return id;
  }*/


  static Future<bool> createPlayer(Player player) async {
    final db = await _getDatabase();

    final existingPlayers = await db.query(
      'players',
      where: 'name = ?',
      whereArgs: [player.name],
      limit: 1,
    );

    if (existingPlayers.isNotEmpty) {
      return false; // Le nom du joueur est déjà pris
    }

    final data = player.toMap();
    final id = await db.insert(
      'players',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id > 0; // Le joueur a été créé avec succès
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