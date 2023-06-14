import 'package:molkky_match/utils/imports.dart';

class SelectPlayersPage extends StatefulWidget {
  const SelectPlayersPage({super.key});

  @override
  SelectPlayersPageState createState() => SelectPlayersPageState();
}

class SelectPlayersPageState extends State<SelectPlayersPage> {
  List<Player> players = [];
  List<bool> selectedPlayers = [];

  @override
  void initState() {
    super.initState();
    _fetchPlayers();
  }

  Future<void> _fetchPlayers() async {
    final List<Player> fetchedPlayers = await DatabaseHelper.getPlayers();
    setState(() {
      players = fetchedPlayers;
      selectedPlayers = List<bool>.filled(fetchedPlayers.length, false);
    });
  }

  void _togglePlayerSelection(int index) {
    setState(() {
      selectedPlayers[index] = !selectedPlayers[index];
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Choisir joueurs",
                style: AppStyles.pageTitleStyle,
              ),
              GestureDetector(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  color: AppColors.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FaIcon(
                      FontAwesomeIcons.plus,
                      size: 25,
                      color: HexColor("222222"),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: size.height,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0, bottom: MediaQuery.of(context).size.height / 3),
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                final isSelected = selectedPlayers[index];

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
                    trailing: isSelected
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                    onTap: () => _togglePlayerSelection(index),
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
          // Pass the selected players to the next screen
          final List<Player> selectedPlayersList = [];
          for (int i = 0; i < players.length; i++) {
            if (selectedPlayers[i]) {
              selectedPlayersList.add(players[i]);
            }
          }
          Navigator.pushNamed(context, '/match/assign_teams');

        },
      ),
    );
  }
}
