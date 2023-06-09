import 'package:molkky_match/utils/imports.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class OutlinedText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextStyle style;
  final double strokeWidth;
  final Color strokeColor;
  final Color textColor;

  const OutlinedText(
      this.text, {
        Key? key,
        this.textAlign = TextAlign.start,
        this.style = const TextStyle(),
        this.strokeWidth = 1.0,
        this.strokeColor = Colors.black,
        this.textColor = Colors.white,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          textAlign: textAlign,
          style: style.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(
          text,
          textAlign: textAlign,
          style: style.copyWith(color: textColor),
        ),
      ],
    );
  }
}
