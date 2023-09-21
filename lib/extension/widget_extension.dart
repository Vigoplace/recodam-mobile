import 'package:recordam/utils/utils.dart';

extension WidgetExtensionss on num {
  Widget get sbH => SizedBox(
        height: h,
      );

  Widget get sbW => SizedBox(
        width: w,
      );
}

extension WidgetExtensions on List<num> {
  EdgeInsetsGeometry get pad {
    assert(length <= 4, 'Length cannot be more than 4');
    assert(length != 3, 'Length cannot be 3');
    if (length == 1) {
      return EdgeInsets.symmetric(
        horizontal: this[0].toDouble(),
      );
    } else if (length == 4) {
      return EdgeInsets.only(
        left: this[0].toDouble(),
        top: this[1].toDouble(),
        right: this[2].toDouble(),
        bottom: this[3].toDouble(),
      );
    }
    return EdgeInsets.symmetric(
      horizontal: this[0].toDouble(),
      vertical: this[1].toDouble(),
    );
  }
}
