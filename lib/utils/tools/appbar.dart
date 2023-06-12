import 'package:molkky_match/utils/imports.dart';

AppBar buildAppbar(scaffoldKey) {
  return AppBar(
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
  );
}

SliverAppBar buildSliverAppBar(scaffoldKey) {
  return SliverAppBar(
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
  );
}