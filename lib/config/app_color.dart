import 'package:recordam/utils/utils.dart';

class ColorConv extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  ColorConv(final String eventryColor) : super(_getColorFromHex(eventryColor));
}

class AppColor {
  /// Grey
  static Color grey30 = ColorConv('#979797');
  static Color grey40 = ColorConv('#757575');
  static Color grey50 = ColorConv('#535353');
  static Color grey70 = ColorConv('#202020');
  static Color grey100 = ColorConv('#0A0A0A');
  static Color grey = ColorConv('#F5F5F5');
  static Color grey1 = ColorConv('#F4F4F4');

  /// Light
  static Color light100 = ColorConv('#545453');
  static Color light90 = ColorConv('#7E7E7D');

  /// Dark
  static Color dark10 = ColorConv('#EAE8E8');
  static Color dark20 = ColorConv('#DBD9D9');

  /// Red
  static Color red30 = ColorConv('#E09090');
  static Color red60 = ColorConv('#C22121');
  static Color red70 = ColorConv('#A21C1C');

  /// Miscellenous
  static Color white = ColorConv('#FFFFFF');
}
