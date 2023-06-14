import 'package:molkky_match/utils/imports.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/feedback':
        return FadePageRoute(page: const FeedbackPage());
      case '/history':
        return FadePageRoute(page: const HistoryPage());
      case '/home':
        return FadePageRoute(page: const HomePage());
      case '/players':
        return FadePageRoute(page: const PlayersPage());
      case '/rules':
        return FadePageRoute(page: const RulesPage());
      case '/statistics':
        return FadePageRoute(page: const StatisticsPage());
      case '/match/select_players':
        return FadePageRoute(page: const SelectPlayersPage());
      case '/match/assign_teams':
        return FadePageRoute(page: const AssignTeamsPage());
      default:
        return FadePageRoute(page: const NotFoundPage());
    }
  }
}
