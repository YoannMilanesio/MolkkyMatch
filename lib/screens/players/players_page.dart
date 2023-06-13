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
          title: Text(player == null ? 'Create Player' : 'Update Player'),
          content: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (player == null) {
                  await _createPlayer(nameController.text);
                } else {
                  player.name = nameController.text;
                  await _updatePlayer(player);
                }

                Navigator.of(context).pop();
                _refreshData();
              },
              child: Text(player == null ? 'Create' : 'Update'),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Players'),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      ) : players.isEmpty
          ? const Center(
        child: Text("No Data Available!!!"),
      )
          : ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];
          return Card(
            color:index%2==0?Colors.green: Colors.green[200],
            margin: const EdgeInsets.all(15),
            child: ListTile(
              title: Text(player.name),
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(),
      ),
    );
  }
}