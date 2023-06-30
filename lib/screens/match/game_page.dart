import 'package:molkky_match/utils/imports.dart';

class GamePage extends StatefulWidget {
  final Match match;

  const GamePage({Key? key, required this.match}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int currentTeamIndex = 0;
  int currentPoints = 0;
  int previousScore = 0;
  int previousTeamIndex = 0;
  List<int> totalScores = [];
  List<List<int>> roundScores = [];
  bool gameEnded = false;
  bool isNumberSelected = false;

  @override
  void initState() {
    super.initState();
    totalScores = List.filled(widget.match.matchTeams.length, 0);
    roundScores = List<List<int>>.generate(widget.match.matchTeams.length, (_) => []);
  }

  void nextTurn() {
    setState(() {
      currentPoints = 0;
      currentTeamIndex = (currentTeamIndex + 1) % widget.match.matchTeams.length;
    });
  }

  void prevTurn() {
    setState(() {
      currentPoints = 0;
      currentTeamIndex = (currentTeamIndex - 1) % widget.match.matchTeams.length;
    });
  }

  void addPoints(int points) {
    setState(() {
      // Vérifier si la partie est déjà terminée
      if (gameEnded) {
        return;
      }

      // Sauvegarder l'état précédent
      previousScore = totalScores[currentTeamIndex];
      previousTeamIndex = currentTeamIndex;

      totalScores[currentTeamIndex] += points;
      roundScores[currentTeamIndex].add(points);

      widget.match.matchRounds.add(Round(
        roundId: widget.match.matchRounds.length + 1,
        matchId: widget.match.matchId,
        score: points,
        playerId: widget.match.matchTeams.first.teamPlayers.first.playerId,
        teamId: widget.match.matchTeams.first.teamId,
      ));

      // Si le score dépasse 50, on le ramène à 25
      if (totalScores[currentTeamIndex] > 50) {
        totalScores[currentTeamIndex] = 25;
      }

      // Vérifier la condition de victoire
      if (totalScores[currentTeamIndex] == 50) {
        // Équipe actuelle a gagné
        gameEnded = true;
        showWinnerDialog(currentTeamIndex);
      } else {
        nextTurn();
        isNumberSelected = false;
      }

      _updateTeamScores(totalScores);

    });
  }

  void missedThrow() {
    setState(() {
      roundScores[currentTeamIndex].add(0);
      nextTurn();
    });
  }

  void cancelLastTurn() {
    setState(() {
      int previousTeamIndex;
      if (currentTeamIndex == 0) {
        previousTeamIndex = widget.match.matchTeams.length - 1;
      } else {
        previousTeamIndex = currentTeamIndex - 1;
      }
      int removedPoints = roundScores[previousTeamIndex].removeLast();
      totalScores[previousTeamIndex] -= removedPoints;
      prevTurn();
    });
  }

  bool areAllScoresZero() {
    return totalScores.every((score) => score == 0);
  }

  Future<void> _updateTeamScores(List<int> totalScores) async {
    for (int i = 0; i < widget.match.matchTeams.length; i++) {
      final team = widget.match.matchTeams[i];
      final score = totalScores[i];
      team.updateTeamScore(score);
    }
  }

  void showWinnerDialog(int teamIndex) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Partie terminée'),
          content: Text('L\'équipe ${teamIndex + 1} a gagné !'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                // Mettre à jour le match dans la base de données
                gameEnded = true;

                _updateTeamScores(totalScores);

                print(widget.match.toString());

                // await DatabaseHelper.updateMatch(widget.match);

                final matchesFromDB = await DatabaseHelper.getMatches();

                for (final match in matchesFromDB) {
                  print('Match ID: ${match.matchId}');
                  print('Match Teams: ${match.matchTeams}');
                  print('Match Rounds: ${match.matchRounds}');
                  print('---------------------------');
                }
                // Naviguer vers la route '/'
                //Navigator.of(context).pushNamed('/');
              },
            ),
            TextButton(
              child: const Text('TEST'),
              onPressed: () async {
                gameEnded = true;
                _updateTeamScores(totalScores);

                print(widget.match.toString());

              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return AppScaffold(
      scaffoldKey: scaffoldKey,
      hauteur: 30,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Tour de l\'équipe ${currentTeamIndex + 1}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(12, (index) {
                final points = index + 1;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (currentPoints == points) {
                        currentPoints = 0;
                        isNumberSelected = false;
                      } else {
                        currentPoints = points;
                        isNumberSelected = true;
                      }
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: currentPoints == points ? Colors.blue : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        points.toString(),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isNumberSelected ? () => addPoints(currentPoints) : () => missedThrow(),
                  child: Text(isNumberSelected ? 'Valider' : 'Raté'),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: areAllScoresZero() || gameEnded ? null : () => cancelLastTurn(),
                  child: const Text('Annuler'),
                ),
                /* const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    print(widget.match.matchRounds.map((round) => round.toString()).toList());
                  },
                  child: const Text('TEST'),
                ), */
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Scores:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: List.generate(widget.match.matchTeams.length, (index) {
                final team = widget.match.matchTeams[index];
                final score = totalScores[index];
                final teamRoundScores = roundScores[index];
                return ListTile(
                  title: Text('Équipe ${index + 1}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Score: $score'),
                      Text(teamRoundScores.map((score) => score == 0 ? 'X' : score.toString()).join(', ')),
                    ],
                  ),
                  trailing: Column(
                    children: List.generate(team.teamPlayers.length, (playerIndex) {
                      final player = team.teamPlayers[playerIndex];
                      return Expanded(child: Text(player.playerName));
                    }),
                  ),
                );
              }),
            ),
            TextButton(
              child: const Text('TEST'),
              onPressed: () async {
                _updateTeamScores(totalScores);

                print('---------------------------');
                print(widget.match.toString());
                print('---------------------------');

                await DatabaseHelper.updateMatch(widget.match);

                final matchesFromDB = await DatabaseHelper.getMatches();

                for (final match in matchesFromDB) {
                    print('Match ID: ${match.matchId}');
                    print('Match Teams: ${match.matchTeams}');
                    print('Match Rounds: ${match.matchRounds}');
                    print('---------------------------');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
