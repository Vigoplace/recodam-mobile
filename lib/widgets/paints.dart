import 'package:recordam/utils/utils.dart';

class CirclePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double length = 28.h + 4.h;

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.58, 0);
    path.lineTo(size.width * 0.58, length);
    path.lineTo(size.width * 0.42, length);
    path.lineTo(size.width * 0.42, 0);
    // path.cubicTo(
    //   size.width * 0.42,
    //   0,
    //   size.width * 0.47,
    //   length,
    //   size.width * 0.5,
    //   length,
    // );
    // path.cubicTo(
    //   size.width * 0.35,
    //   length,
    //   size.width * 0.4,
    //   0,
    //   size.width * 0.4 - 80,
    //   0,
    // );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
