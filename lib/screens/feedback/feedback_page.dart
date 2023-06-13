import 'package:molkky_match/utils/imports.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController textarea = TextEditingController();

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
            const Text(
              "Qu'en penses-tu ?",
              style: AppStyles.pageTitleStyle,
            ),
            const SizedBox(height: 30),
            const Text(
              "Nous vous remercions d’utiliser notre application et nous serions ravis de pouvoir l’améliorer. Alors n’hésitez-pas à nous faire un retour !",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            const Text(
              "Noter votre expérience :",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FaIcon(
                  FontAwesomeIcons.faceAngry,
                  size: 46,
                  color: AppColors.whiteColor,
                ),
                FaIcon(
                  FontAwesomeIcons.faceGrimace,
                  size: 46,
                  color: AppColors.whiteColor,
                ),
                FaIcon(
                  FontAwesomeIcons.faceMeh,
                  size: 46,
                  color: AppColors.whiteColor,
                ),
                FaIcon(
                  FontAwesomeIcons.faceSmileBeam,
                  size: 46,
                  color: AppColors.whiteColor,
                ),
                FaIcon(
                  FontAwesomeIcons.faceGrinHearts,
                  size: 46,
                  color: AppColors.whiteColor,
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Laissez un commentaire :",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: textarea,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: HexColor("E6E6E6").withOpacity(0.85),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: AppStyles.primaryButtonStyle,
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Envoyer',
                  style: AppStyles.primaryButtonTextStyle,
                ),
              ),
            ),
          ],
        )
    );
  }
}
