import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:recordam/resources/resources.dart';

void main() {
  test('app_svg assets test', () {
    expect(File(AppSvg.agenda).existsSync(), true);
    expect(File(AppSvg.bell).existsSync(), true);
    expect(File(AppSvg.book).existsSync(), true);
    expect(File(AppSvg.card).existsSync(), true);
    expect(File(AppSvg.checked).existsSync(), true);
    expect(File(AppSvg.checkmark).existsSync(), true);
    expect(File(AppSvg.clock).existsSync(), true);
    expect(File(AppSvg.directionRight).existsSync(), true);
    expect(File(AppSvg.eyeOpen).existsSync(), true);
    expect(File(AppSvg.eye).existsSync(), true);
    expect(File(AppSvg.menu).existsSync(), true);
    expect(File(AppSvg.moreHoriz).existsSync(), true);
    expect(File(AppSvg.moreVert).existsSync(), true);
    expect(File(AppSvg.record).existsSync(), true);
    expect(File(AppSvg.rect).existsSync(), true);
    expect(File(AppSvg.search).existsSync(), true);
    expect(File(AppSvg.searchBlack).existsSync(), true);
    expect(File(AppSvg.share).existsSync(), true);
    expect(File(AppSvg.upload).existsSync(), true);
  });
}
