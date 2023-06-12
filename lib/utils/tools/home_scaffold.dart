import 'package:molkky_match/utils/imports.dart';

class HomeScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final double hauteur;
  final Widget body;

  const HomeScaffold({super.key, required this.scaffoldKey, required this.hauteur, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      drawerEnableOpenDragGesture: true,
      appBar: buildAppbar(scaffoldKey),
      drawer: buildDrawer(context, scaffoldKey),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/img/background_grass.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            color: HexColor("9D9D9D").withOpacity(0.8),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: hauteur),
              child: body
          ),
        ],
      ),
    );
  }
}