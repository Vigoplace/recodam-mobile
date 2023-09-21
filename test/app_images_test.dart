import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:recordam/resources/resources.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.onboarding).existsSync(), true);
    expect(File(AppImages.splash).existsSync(), true);
  });
}
