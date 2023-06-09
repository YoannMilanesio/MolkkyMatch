import 'package:molkky_match/utils/imports.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = 0.0;
      var end = 1.0;
      var curve = Curves.linearToEaseOut;
      var opacityTween = Tween<double>(begin: begin, end: end).chain(CurveTween(curve: curve));

      return FadeTransition(
        opacity: animation.drive(opacityTween),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 800),
  );
}
