import 'package:recordam/utils/utils.dart';

class CustomTextStyle {
  static TextStyle text700_30 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 30.sp,
    color: Colors.black,
  );
  static TextStyle text700_18 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18.sp,
    color: Colors.black,
  );
  static TextStyle text500_16 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    color: Colors.black,
  );
  static TextStyle text500_18 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: Colors.black,
  );
  static TextStyle text500_14 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    color: Colors.black,
  );
  static TextStyle text500_25 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 25.sp,
    color: Colors.black,
  );
  static TextStyle text500_24 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 24.sp,
    color: Colors.black,
  );
  static TextStyle text500_20 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.sp,
    color: Colors.black,
  );
  static TextStyle text500_12 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    color: Colors.black,
  );
  static TextStyle text500_10 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 10.sp,
    color: Colors.black,
  );
  static TextStyle text500_30 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 30.sp,
    color: Colors.black,
  );
  static TextStyle text400_14 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: Colors.black,
  );
  static TextStyle text400_16 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: Colors.black,
  );
  static TextStyle text400_18 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
    color: Colors.black,
  );
  static TextStyle text400_15 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 15.sp,
    color: Colors.black,
  );
  static TextStyle text400_12 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: Colors.black,
  );
}

extension TextStyleExtensions on TextStyle {
  /// w700
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  /// w400
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  /// w500
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// w500
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  /// With color
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle underline() {
    return copyWith(decoration: TextDecoration.underline);
  }
}
