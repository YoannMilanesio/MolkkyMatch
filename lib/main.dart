import 'package:molkky_match/utils/imports.dart';

void main() => runApp(const MolkkyMatchApp());

class MolkkyMatchApp extends StatelessWidget {
  const MolkkyMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mölkky Match',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme.copyWith(
            displayLarge: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: 24,
              color: AppColors.whiteColor
            ),
            titleMedium: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 20,
              color: AppColors.whiteColor
            ),
            bodyMedium: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              color: AppColors.whiteColor
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
