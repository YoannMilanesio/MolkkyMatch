import 'package:molkky_match/utils/imports.dart';

class Match {
  int id;
  DateTime date;
  List<List<Player>> teams;
  List<int> scores;

  Match({
    required this.id,
    required this.date,
    required this.teams,
    required this.scores,
  });

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      id: map['id'],
      date: DateTime.parse(map['date']),
      teams: map['teams'],
      scores: map['scores'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'teams': teams,
      'scores': scores,
    };
  }
}
