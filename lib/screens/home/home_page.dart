import 'package:molkky_match/utils/imports.dart';
import 'dart:ui';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;

    return AppScaffold(
      scaffoldKey: scaffoldKey,
      hauteur: size.height * 0.25,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text(
                'Mölkky',
                textAlign: TextAlign.center,
                style: AppStyles.homeTitleTextStyle,
              ),
              Text(
                'Match',
                textAlign: TextAlign.center,
                style: AppStyles.homeTitleOutlinedTextStyle,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
              'La stratégie de lancer, le plaisir du jeu... et un peu de maths',
              textAlign: TextAlign.center,
              style: AppStyles.homeQuoteTextStyle
          ),
          const SizedBox(height: 32),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: AppStyles.primaryButtonStyle,
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Nouvelle Partie',
                    style: AppStyles.primaryButtonTextStyle,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: AppStyles.secondaryButtonStyle,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Reprendre la partie',
                    style: AppStyles.secondaryButtonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}