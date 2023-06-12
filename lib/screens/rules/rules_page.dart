import 'package:molkky_match/utils/imports.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  List<dynamic> molkkyData = [];
  List<dynamic> molkkoutData = [];
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String molkkyJsonString = await rootBundle.loadString('lib/screens/rules/doc/molkky_rules.json');
    String molkkoutJsonString = await rootBundle.loadString('lib/screens/rules/doc/molkkout_rules.json');
    setState(() {
      molkkyData = jsonDecode(molkkyJsonString)['rules'];
      molkkoutData = jsonDecode(molkkoutJsonString)['rules'];
    });
  }

  Widget buildSubtitleWidget(dynamic subtitle) {
    final subtitleText = subtitle['subtitle'];
    final paragraphs = subtitle['paragraphs'];
    final photoPath = subtitle['photo'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            subtitleText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...paragraphs.map<Widget>((paragraph) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(paragraph),
        )),
        if (photoPath != null) // Check if photoPath exists
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              photoPath,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }

  Widget buildRulesWidget(List<dynamic> data) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0, bottom: MediaQuery.of(context).size.height / 4),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        final title = item['title'];
        final subtitles = item['subtitles'];
        final paragraphs = item['paragraphs'];
        index += 1;

        final titleWidget = Visibility(
          visible: title != null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$index) $title',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );

        final subtitleWidgets = subtitles != null
            ? subtitles.map<Widget>((subtitle) {
          return buildSubtitleWidget(subtitle);
        }).toList()
            : paragraphs.map<Widget>((paragraph) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(paragraph),
          );
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleWidget,
            ...subtitleWidgets,
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;

    return AppScaffold(
      scaffoldKey: scaffoldKey,
      hauteur: 20,
      body: DefaultTabController(
        length: 2,
        initialIndex: currentTabIndex,
        child: Column(
          children: [
            TabBar(
              labelColor: AppColors.whiteColor,
              unselectedLabelColor: AppColors.whiteColor.withOpacity(0.6),
              labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
                insets: EdgeInsets.symmetric(horizontal: 15),
              ),
              tabs: const [
                Tab(text: 'Mölkky'),
                Tab(text: 'Mölkkout'),
              ],
              onTap: (index) {
                setState(() {
                  currentTabIndex = index;
                });
              },
            ),
            SizedBox(
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    molkkyData.isEmpty
                        ? const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Center(
                        child: CircularProgressIndicator(color: AppColors.whiteColor),
                      ),
                    ) : buildRulesWidget(molkkyData),
                    molkkoutData.isEmpty
                        ? const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Center(
                        child: CircularProgressIndicator(color: AppColors.whiteColor),
                      ),
                    ) : buildRulesWidget(molkkoutData),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
