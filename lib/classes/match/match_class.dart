import 'package:molkky_match/utils/imports.dart';

class Match {
  int matchId;
  DateTime? matchDate;
  List<Team> matchTeams;
  List<Round> matchRounds;

  Match({
    required this.matchId,
    this.matchDate,
    required this.matchTeams,
    required this.matchRounds,
  });

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      matchId: map['matchId'],
      matchDate: DateTime.parse(map['matchDate']),
      matchTeams: (map['matchTeams'] as List<dynamic>)
          .map((teamMap) => Team.fromMap(teamMap))
          .toList(),
      matchRounds: (map['matchRounds'] as List<dynamic>)
          .map((roundMap) => Round.fromMap(roundMap))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'matchId': matchId,
      'matchDate': matchDate?.toIso8601String(),
      'matchTeams': matchTeams.map((team) => team.toMap()).toList(),
      'matchRounds': matchRounds.map((round) => round.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return '(Match ID: $matchId, Date: $matchDate, Team Players: $matchTeams, Rounds: $matchRounds)';
  }
}
