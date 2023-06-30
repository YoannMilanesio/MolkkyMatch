import 'package:molkky_match/utils/imports.dart';

class Team {
  int teamId;
  List<Player> teamPlayers;
  int teamScore;

  Team({
    required this.teamId,
    required this.teamPlayers,
    required this.teamScore,
  });

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      teamId: map['teamId'],
      teamPlayers: (map['teamPlayers'] as List<dynamic>)
          .map((playerData) => Player.fromMap(playerData))
          .toList(),
      teamScore: map['teamScore'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teamId': teamId,
      'teamPlayers': teamPlayers.map((player) => player.toMap()).toList(),
      'teamScore': teamScore,
    };
  }

  @override
  String toString() {
    return '(Team ID: $teamId, Team Players: $teamPlayers, Score: $teamScore)';
  }

  void updateTeamScore(int newScore) {
    teamScore = newScore;
  }
}
