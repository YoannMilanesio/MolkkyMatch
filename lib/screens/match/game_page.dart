import 'package:molkky_match/utils/imports.dart';

class GamePage extends StatefulWidget {
  final Match match;

  const GamePage({super.key, required this.match});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;
    List<List<Player>> teams = widget.match.teams;
    List<int> scores = widget.match.scores;

    return AppScaffold(
      scaffoldKey: scaffoldKey,
      hauteur: 30,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < teams.length; i++)
            Column(
              children: [
                Text('Équipe ${i + 1}'),
                for (int j = 0; j < teams[i].length; j++)
                  Text(teams[i][j].name),
                Text('Score: ${scores[i]}'),
                const SizedBox(height: 20),
              ],
            ),
        ],
      ),
    );
  }

}
