import 'package:molkky_match/utils/imports.dart';

class AppScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final double hauteur;
  final Widget body;
  final Widget? floatingActionButton;

  const AppScaffold({super.key, required this.scaffoldKey, required this.hauteur, required this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/img/background_grass.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: HexColor("9D9D9D").withOpacity(0.8),
          ),
          CustomScrollView(
            slivers: [
              buildSliverAppBar(scaffoldKey),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: hauteur),
                  child: body,
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: buildDrawer(context, scaffoldKey),
      floatingActionButton: floatingActionButton,
    );
  }
}

