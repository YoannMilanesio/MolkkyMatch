import 'package:molkky_match/utils/imports.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Match> matches = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() async {
    final data = await DatabaseHelper.getMatches();
    setState(() {
      matches = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;

    return AppScaffold(
        scaffoldKey: scaffoldKey,
        hauteur: 30,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Historique",
              style: AppStyles.pageTitleStyle,
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                /* for (int i = 0; i <= 150; i++) {
                  await DatabaseHelper.deleteMatch(i);
                }*/
                print(matches.toString());
                // print(widget.match.matchTeams.toString());
                //print(teamPlayers.map((team) => team.map((player) => player.playerName).toList()).toList());
              },
            ),
            const SizedBox(height: 15),
            isLoading
            ? const Center(
              child: CircularProgressIndicator()
            ) : matches.isEmpty
        ? const Center(
              child: Text("No Data Available!!!"),
            ) : SizedBox(
              height: size.height,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0, bottom: MediaQuery.of(context).size.height / 3),
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final match = matches[index];
                  return Card(
                    key: UniqueKey(),
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: AppColors.whiteColor.withOpacity(0.65),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            match.matchDate.toString(), // Formatage de la date
                            style: TextStyle(
                              color: HexColor("222222"),
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 10),
                          for (int i = 0; i < match.matchTeams.length; i++) ...[
                            Row(
                              children: [
                                Text(
                                  'Score: ${match.matchTeams[i].teamScore}', // Affichage du score de l'équipe
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (int j = 0; j < match.matchTeams[i].teamPlayers.length; j++) ...[
                                      Text(
                                        match.matchTeams[i].teamPlayers[j].playerName, // Affichage du nom du joueur
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}
