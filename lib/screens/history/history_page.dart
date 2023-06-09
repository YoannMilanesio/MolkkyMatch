import 'package:molkky_match/utils/imports.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;

    return AppScaffold(
        scaffoldKey: scaffoldKey,
        hauteur: 120,
        body: const Text("Historique")
    );
  }
}
