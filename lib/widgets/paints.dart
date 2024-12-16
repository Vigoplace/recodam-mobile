import 'package:recordam/utils/utils.dart';

class CirclePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double length = 28 + 4;

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2 + length * 1.6, 0);
    path.cubicTo(
      size.width / 2 + length * 0.57,
      0,
      size.width / 2 + length * 1.15,
      length,
      size.width * 0.5,
      length,
    );
    path.cubicTo(
      size.width / 2 - length * 0.9,
      length,
      size.width / 2 - length * 0.8,
      0,
      size.width / 2 - length * 1.57,
      0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
