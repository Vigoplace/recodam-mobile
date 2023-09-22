import 'package:recordam/utils/utils.dart';

class CustomTextStyle {
  // 700
  static TextStyle text700_32 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 32.sp,
    color: Colors.black,
  );
  static TextStyle text700_20 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20.sp,
    color: Colors.black,
  );
  static TextStyle text700_18 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18.sp,
    color: Colors.black,
  );
  static TextStyle text700_16 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
    color: Colors.black,
  );
  static TextStyle text700_14 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14.sp,
    color: Colors.black,
  );
  static TextStyle text700_11 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 11.sp,
    color: Colors.black,
  );

  // 600
  static TextStyle text600_14 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
    color: Colors.black,
  );

  // 500
  static TextStyle text500_14 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    color: Colors.black,
  );

  // 400
  static TextStyle text400_16 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: Colors.black,
  );
  static TextStyle text400_14 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: Colors.black,
  );
  static TextStyle text400_12 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: Colors.black,
  );
}

extension TextStyleExtensions on TextStyle {
  /// With color
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle underline() {
    return copyWith(decoration: TextDecoration.underline);
  }
}
