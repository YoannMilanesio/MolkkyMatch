import 'package:molkky_match/utils/imports.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  List<dynamic> jsonData = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('lib/screens/rules/doc/rules.json');
    setState(() {
      jsonData = jsonDecode(jsonString)['rules'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;

    return AppScaffold(
        scaffoldKey: scaffoldKey,
        hauteur: 120,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Règles du Mölkky",
              style: AppStyles.pageTitleStyle,
            ),
            jsonData.isEmpty ?
              const Center(child: CircularProgressIndicator()) :
              Expanded(
                child: ListView.builder(
                  itemCount: jsonData.length,
                  itemBuilder: (context, index) {
                    final item = jsonData[index];
                    final title = item['title'];
                    final subtitle = item['subtitle'];
                    final paragraphs = item['paragraphs'];

                    final titleWidget = Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: AppStyles.pageSubtitleStyle,
                      ),
                    );

                    final subtitleWidget = subtitle != null ?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          subtitle,
                          style: AppStyles.pageSubtitleStyle
                        ),
                      )
                      : Container();

                    final paragraphsWidgets = paragraphs.map((paragraph) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(paragraph),
                    ));

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleWidget,
                        subtitleWidget,
                        ...paragraphsWidgets,
                      ],
                    );
                  },
                ),
              )
          ],
        ),
    );
  }
}

