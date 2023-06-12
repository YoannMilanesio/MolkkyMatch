import 'package:molkky_match/utils/imports.dart';
import 'dart:ui';

Drawer buildDrawer(context, scaffoldKey) {
  return Drawer(
    backgroundColor: Colors.white.withOpacity(0.3),
    width: MediaQuery.of(context).size.width,
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
  );
}