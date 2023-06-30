import 'package:molkky_match/utils/imports.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static sql.Database? _database;

  static Future<sql.Database> _getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    final dbPath = await sql.getDatabasesPath();
    final dbFile = path.join(dbPath, 'molkky_match.db');

    _database = await sql.openDatabase(
      dbFile,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE players(
            playerId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            playerName TEXT UNIQUE,
            createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            updatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
          )
        """);

        await db.execute("""
          CREATE TABLE teams(
            teamId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            teamPlayers TEXT,
            teamScore INTEGER
          )
        """);

        await db.execute('''
          CREATE TABLE matches(
            matchId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            matchDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            matchTeams TEXT,
            matchRounds TEXT
          )
        ''');
      },
    );

    return _database!;
  }


  // PLAYERS

  static Future<bool> createPlayer(Player player) async {
    final db = await _getDatabase();

    try {
      final id = await db.insert(
        'players',
        player.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
      return id > 0;
    } catch (e) {
      if (e is sql.DatabaseException && e.isUniqueConstraintError()) {
        return false; // Le nom du joueur est déjà pris
      }
      rethrow;
    }
  }

  static Future<List<Player>> getPlayers() async {
    final db = await _getDatabase();
    final results = await db.query('players', orderBy: "playerName");
    return results.map((data) => Player.fromMap(data)).toList();
  }

  static Future<Player?> getPlayer(int id) async {
    final db = await _getDatabase();
    final results = await db.query('players', where: "playerId = ?", whereArgs: [id], limit: 1);

    if (results.isNotEmpty) {
      return Player.fromMap(results.first);
    }

    return null;
  }

  static Future<int> updatePlayer(Player player) async {
    final db = await _getDatabase();

    final data = {
      'playerName': player.playerName,
      'updatedAt': DateTime.now().toIso8601String(),
    };

    final result = await db.update('players', data, where: "playerId = ?", whereArgs: [player.playerId]);
    return result;
  }

  static Future<void> deletePlayer(int id) async {
    final db = await _getDatabase();
    try {
      await db.delete("players", where: "playerId = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }

  // TEAM
  static Future<int> updateTeamScore(Team team) async {
    final db = await _getDatabase();

    final data = {
      'teamScore': team.teamScore,
    };

    final result = await db.update('teams', data, where: "teamId = ?", whereArgs: [team.teamId]);
    return result;
  }

  // MATCHES

  static Future<void> createMatch(Match match) async {
    final db = await _getDatabase();

    final teamsJson = jsonEncode(match.matchTeams.map((team) => team.toMap()).toList());
    final roundsJson = jsonEncode(match.matchRounds.map((round) => round.toMap()).toList());

    final values = {
      'matchTeams': teamsJson,
      'matchRounds': roundsJson,
    };

    await db.insert(
      'matches',
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Match>> getMatches() async {
    final db = await _getDatabase();
    final results = await db.query('matches');

    return results.map((data) {
      final teamsJson = jsonDecode(data['matchTeams'] as String);
      final roundsJson = jsonDecode(data['matchRounds'] as String);

      final matchDate = DateTime.parse(data['matchDate'] as String);

      final teams = (teamsJson as List<dynamic>)
          .map((teamData) => Team.fromMap(teamData))
          .toList();

      final rounds = (roundsJson as List<dynamic>)
          .map((roundData) => Round.fromMap(roundData))
          .toList();

      return Match(
        matchId: data['matchId'] as int,
        matchDate: matchDate,
        matchTeams: teams,
        matchRounds: rounds,
      );
    }).toList();
  }


  static Future<int> updateMatch(Match match) async {
    final db = await _getDatabase();

    final teamsJson = jsonEncode(match.matchTeams.map((team) => team.toMap()).toList());
    final roundsJson = jsonEncode(match.matchRounds.map((round) => round.toMap()).toList());

    final data = {
      'matchTeams': teamsJson,
      'matchRounds': roundsJson,
    };

    final result = await db.update('matches', data, where: "matchId = ?", whereArgs: [match.matchId]);
    return result;
  }

  static Future<void> deleteMatch(int id) async {
    final db = await _getDatabase();
    try {
      await db.delete("matches", where: "matchId = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}