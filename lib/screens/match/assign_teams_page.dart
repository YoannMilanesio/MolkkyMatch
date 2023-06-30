import 'package:molkky_match/utils/imports.dart';

class AssignTeamsPage extends StatefulWidget {
  final List<Player> selectedPlayers;

  const AssignTeamsPage(this.selectedPlayers, {Key? key}) : super(key: key);

  @override
  AssignTeamsPageState createState() => AssignTeamsPageState();
}

class AssignTeamsPageState extends State<AssignTeamsPage> {
  List<Team> teams = [];
  List<Color> teamColors = [
    HexColor("2A46A3"),
    HexColor("BF0C0C"),
    HexColor("2E784C"),
  ];
  int selectedTeamCount = 2;

  @override
  void initState() {
    super.initState();
    initializeTeams();
  }

  void initializeTeams() {
    teams = List.generate(selectedTeamCount, (index) {
      return Team(teamId: index + 1, teamPlayers: [], teamScore: 0);
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
            "Les équipes",
            style: AppStyles.pageTitleStyle,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Text("Nombre d'équipes :"),
              const SizedBox(width: 10),
              Switch(
                value: selectedTeamCount == 3,
                onChanged: (value) {
                  setState(() {
                    selectedTeamCount = value ? 3 : 2;
                    initializeTeams();
                  });
                },
                activeTrackColor: Colors.grey,
                activeColor: Colors.blue,
              ),
              Text(selectedTeamCount.toString()),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: size.height,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0, bottom: MediaQuery.of(context).size.height / 3),
              itemCount: widget.selectedPlayers.length,
              itemBuilder: (context, index) {
                final player = widget.selectedPlayers[index];

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: AppColors.whiteColor.withOpacity(0.65),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      player.playerName,
                      style: TextStyle(
                        color: HexColor("222222"),
                        fontSize: 22,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        selectedTeamCount,
                            (teamIndex) {
                              final team = teams[teamIndex];
                              final isSelected = team.teamPlayers.contains(player);

                              return InkWell(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  // Si le joueur est déjà assigné à cette équipe, désélectionnez-le
                                  team.teamPlayers.remove(player);
                                } else {
                                  // Sinon, assignez-le à cette équipe
                                  team.teamPlayers.add(player);

                                  // Vérifiez si le joueur était assigné à une autre équipe et le supprimer de cette équipe
                                  for (var otherTeam in teams) {
                                    if (otherTeam != team && otherTeam.teamPlayers.contains(player)) {
                                      otherTeam.teamPlayers.remove(player);
                                    }
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: teams[teamIndex].teamPlayers.contains(player)
                                    ? teamColors[teamIndex]
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(color: teamColors[teamIndex], width: 2),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () async {
          // Créez les équipes pour le match
          List<List<Player>> teamPlayers = teams.map((team) => team.teamPlayers).toList();

          // Créez les rounds (pour l'instant vide)
          List<Round> rounds = [];

          // Créez l'instance de Match avec les équipes, les scores et les rounds
          Match match = Match(
            matchId: 0,
            matchDate: DateTime.now(),
            matchTeams: teams,
            matchRounds: rounds,
          );

          await DatabaseHelper.createMatch(match);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GamePage(match: match),
            ),
          );

          print(teamPlayers.map((team) => team.map((player) => player.playerName).toList()).toList());
        },
      ),
    );
  }
}
