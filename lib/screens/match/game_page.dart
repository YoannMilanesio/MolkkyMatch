import 'package:molkky_match/utils/imports.dart';

class GamePage extends StatefulWidget {
  final Match match;

  const GamePage({super.key, required this.match});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int currentTeamIndex = 0;
  int currentPoints = 0;
  int previousScore = 0;
  int previousTeamIndex = 0;
  List<int> totalScores = [];
  List<List<int>> roundScores = [];
  bool gameEnded = false;

  @override
  void initState() {
    super.initState();
    totalScores = List.filled(widget.match.teams.length, 0);
    roundScores = List<List<int>>.generate(widget.match.teams.length, (_) => []);
  }

  void nextTurn() {
    setState(() {
      currentPoints = 0;
      currentTeamIndex = (currentTeamIndex + 1) % widget.match.teams.length;
    });
  }

  void prevTurn() {
    setState(() {
      currentPoints = 0;
      currentTeamIndex = (currentTeamIndex - 1) % widget.match.teams.length;
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
      }
    });
  }

  void cancelLastTurn() {
    setState(() {
      int previousTeamIndex;
      if (currentTeamIndex == 0) {
        previousTeamIndex = widget.match.teams.length - 1;
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
              onPressed: () {
                // Ajoutez ici votre logique pour gérer la fin de la partie
                Navigator.of(context).pop();
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
                      currentPoints = points;
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
                  onPressed: currentPoints > 0 ? () => addPoints(currentPoints) : null,
                  child: const Text('Valider'),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: areAllScoresZero() || gameEnded ? null : () => cancelLastTurn(),
                  child: const Text('Annuler'),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Scores:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: List.generate(widget.match.teams.length, (index) {
                final team = widget.match.teams[index];
                final score = totalScores[index];
                final teamRoundScores = roundScores[index];
                return ListTile(
                  title: Text('Équipe ${index + 1}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Score: $score'),
                      Text(teamRoundScores.join(', ')),

                    ],
                  ),
                  trailing: Column(
                    children: List.generate(team.length, (playerIndex) {
                      final player = team[playerIndex];
                      return Text(player.name);
                    }),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

}
