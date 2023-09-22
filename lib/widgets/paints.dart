import 'package:recordam/utils/utils.dart';

class CirclePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double length = 28.h + 4.h;

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.64, 0);
    path.cubicTo(
      size.width * 0.55,
      0,
      size.width * 0.6,
      length,
      size.width * 0.5,
      length,
    );
    path.cubicTo(
      size.width * 0.42,
      length,
      size.width * 0.43,
      0,
      size.width * 0.36,
      0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
