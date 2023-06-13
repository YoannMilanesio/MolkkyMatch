import 'package:molkky_match/utils/imports.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({super.key});

  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  List<Player> players = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() async {
    final data = await DatabaseHelper.getPlayers();
    setState(() {
      players = data;
      isLoading = false;
    });
  }

  void _showForm({Player? player}) {
    final TextEditingController nameController = TextEditingController();

    if (player != null) {
      nameController.text = player.name;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(player == null ? 'Ajouter joueur' : 'Modifier joueur',
              style: TextStyle(
                fontSize: 23,
                color: HexColor("222222"),
              ),
            ),
          ),
          content: TextFormField(
            textAlign: TextAlign.center,
            style: TextStyle(
                color: HexColor("222222")
            ),
            controller: nameController,
          ),
          actions: [
            Center(child: SizedBox(width: MediaQuery.of(context).size.width / 1.5, child: Divider(color: HexColor("9D9D9D")))),
            Center(
              child: GestureDetector(
                onTap: () async {
                  if (player == null) {
                    await _createPlayer(nameController.text);
                  } else {
                    player.name = nameController.text;
                    await _updatePlayer(player);
                  }

                  Navigator.of(context).pop();
                  _refreshData();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(player == null ? 'Ajouter' : 'Modifier',
                    style: TextStyle(
                      color: HexColor("222222"),
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            Center(child: SizedBox(width: MediaQuery.of(context).size.width / 1.5, child: Divider(color: HexColor("9D9D9D")))),
            Center(
              child: GestureDetector(
                onTap: () async {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text('Annuler',
                    style: TextStyle(
                        color: HexColor("222222"),
                        fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createPlayer(String name) async {
    final existingPlayers = await DatabaseHelper.getPlayers();
    final isNameTaken = existingPlayers.any((player) => player.name == name);

    if (isNameTaken) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ce nom de joueur est déjà pris. Veuillez en choisir un autre.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      final player = Player(
        id: null,
        name: name,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await DatabaseHelper.createPlayer(player);
      _refreshData();
    }
  }

  Future<void> _updatePlayer(Player player) async {
    player.updatedAt = DateTime.now();
    await DatabaseHelper.updatePlayer(player);
  }

  void _deletePlayer(int playerId) async {
    await DatabaseHelper.deletePlayer(playerId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Player deleted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    _refreshData();
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
                "Liste des joueurs",
                style: AppStyles.pageTitleStyle,
              ),
              GestureDetector(
                onTap: () => _showForm(),
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
          isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          ) : players.isEmpty
              ? const Center(
            child: Text("No Data Available!!!"),
          )
              : SizedBox(
                height: size.height,
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 0, bottom: MediaQuery.of(context).size.height / 3),
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                      final player = players[index];
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
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _showForm(player: player),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _deletePlayer(player.id!),
                                ),
                              ],
                            ),
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