class Player {
  int playerId;
  String playerName;
  DateTime createdAt;
  DateTime updatedAt;

  Player({
    required this.playerId,
    required this.playerName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      playerId: map['playerId'],
      playerName: map['playerName'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playerId': playerId,
      'playerName': playerName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Player(name: $playerName, id: $playerId)'; // Remplacez les propriétés selon votre classe Player
  }
}
