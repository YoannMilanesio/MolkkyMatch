import 'package:molkky_match/utils/imports.dart';
import 'dart:ui';

class AppScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final double hauteur;
  final Widget body;

  const AppScaffold({super.key, required this.scaffoldKey, required this.hauteur, required this.body});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.barsStaggered,
              size: 25,
              color: AppColors.whiteColor,
            ),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.gear,
                size: 25,
                color: AppColors.whiteColor,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white.withOpacity(0.3),
        width: size.width,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: IconButton(
                      alignment: Alignment.centerLeft,
                      icon: const FaIcon(
                        FontAwesomeIcons.xmark,
                        size: 30,
                        color: AppColors.whiteColor,
                      ),
                      onPressed: () {
                        scaffoldKey.currentState?.openEndDrawer();
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 25,
                      child: FaIcon(
                        FontAwesomeIcons.house,
                        size: 28,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    title: const Text(
                      "Accueil",
                      style: AppStyles.drawerTextStyle,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 25,
                      child: FaIcon(
                        FontAwesomeIcons.clipboardUser,
                        size: 28,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    title: const Text(
                      "Règles",
                      style: AppStyles.drawerTextStyle,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/rules');
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 25,
                      child: FaIcon(
                        FontAwesomeIcons.users,
                        size: 28,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    title: const Text(
                      "Joueurs",
                      style: AppStyles.drawerTextStyle,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/players');
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 25,
                      child: FaIcon(
                        FontAwesomeIcons.clockRotateLeft,
                        size: 28,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    title: const Text(
                      "Historique",
                      style: AppStyles.drawerTextStyle,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/history');
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 25,
                      child: FaIcon(
                        FontAwesomeIcons.chartPie,
                        size: 28,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    title: const Text(
                      "Statistiques",
                      style: AppStyles.drawerTextStyle,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/statistics');
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 25,
                      child: FaIcon(
                        FontAwesomeIcons.comment,
                        size: 28,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    title: const Text(
                      "Feedback",
                      style: AppStyles.drawerTextStyle,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/feedback');
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
