import 'package:molkky_match/utils/imports.dart';

class AssignTeamsPage extends StatefulWidget {
  final List<Player> selectedPlayers;

  const AssignTeamsPage(this.selectedPlayers, {super.key});

  @override
  AssignTeamsPageState createState() => AssignTeamsPageState();
}

class AssignTeamsPageState extends State<AssignTeamsPage> {
  List<List<String>> selectedTeams = [];
  List<Color> teamColors = [HexColor("2A46A3"), HexColor("BF0C0C"), HexColor("2E784C")];
  int selectedTeamCount = 2;

  @override
  void initState() {
    super.initState();
    selectedTeams = List.generate(widget.selectedPlayers.length, (_) => List.filled(selectedTeamCount, ''));
  }

  void updateSelectedTeams() {
    setState(() {
      selectedTeams = List.generate(widget.selectedPlayers.length, (_) => List.filled(selectedTeamCount, ''));
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
                    updateSelectedTeams();
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
                      player.name,
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
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (selectedTeams[index][teamIndex] == teamColors[teamIndex].toString()) {
                                  // Si le joueur est déjà assigné à cette équipe, désélectionnez-le
                                  selectedTeams[index][teamIndex] = '';
                                } else {
                                  // Sinon, assignez-le à cette équipe et désélectionnez l'équipe précédente
                                  selectedTeams[index] = List.filled(selectedTeamCount, '');
                                  selectedTeams[index][teamIndex] = teamColors[teamIndex].toString();
                                }
                              });
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: selectedTeams[index][teamIndex] == teamColors[teamIndex].toString()
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
        onPressed: () {
          // Proceed to the next step
        },
      ),
    );
  }
}
