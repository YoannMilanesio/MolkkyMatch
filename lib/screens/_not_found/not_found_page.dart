import 'package:molkky_match/utils/imports.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;

    return AppScaffold(
        scaffoldKey: scaffoldKey,
        hauteur: 120,
        body:  const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("La page n'existe pas (ou plus), nous sommes désolé.",
              style: AppStyles.pageTitleStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
    );
  }
}
