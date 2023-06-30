class Round {
  int roundId;
  int matchId;
  int score;
  int playerId;
  int teamId;

  Round({
    required this.roundId,
    required this.matchId,
    required this.score,
    required this.playerId,
    required this.teamId,
  });

  factory Round.fromMap(Map<String, dynamic> map) {
    return Round(
      roundId: map['roundId'],
      matchId: map['matchId'],
      score: map['score'],
      playerId: map['playerId'],
      teamId: map['teamId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roundId': roundId,
      'matchId': matchId,
      'score': score,
      'playerId': playerId,
      'teamId': teamId,
    };
  }

  @override
  String toString() {
    return '(Round ID: $roundId, Match ID: $matchId, Score: $score, Player ID: $playerId, Team ID: $teamId)';
  }
}
