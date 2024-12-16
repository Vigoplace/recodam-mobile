import 'package:recordam/utils/utils.dart';

extension NumberExtensions on num {
  SizedBox get verticalSpacing {
    return SizedBox(
      height: toDouble(),
    );
  }

  SizedBox get horizontalSpacing {
    return SizedBox(
      width: toDouble(),
    );
  }
}
