import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ViewPdf extends StatelessWidget {
  final String path;
  const ViewPdf({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return PDFView(
      filePath: path,
      gestureRecognizers: {
        Factory(() => EagerGestureRecognizer()),
      },
    );
  }
}
