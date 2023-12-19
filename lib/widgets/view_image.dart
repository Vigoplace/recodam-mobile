import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:recordam/utils/utils.dart';

class ViewImage extends StatelessWidget {
  final String? image;
  final DetailType? detailType;
  final String appBarText;
  const ViewImage({
    super.key,
    required this.image,
    required this.appBarText,
    this.detailType,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: false,
        title: appBarText,
      ),
      backgroundColor: AppColor.grey,
      body: InteractiveViewer(
        child: Center(
          child: detailType == DetailType.create
              ? switch (image!.endsWith('pdf')) {
                  true => Center(
                      child: Builder(builder: (context) {
                        return PdfView(
                          path: image!,
                          gestureRecognizers: {
                            Factory(
                              () => EagerGestureRecognizer(),
                            ),
                          },
                        );
                      }),
                    ),
                  _ => Image.file(File(image!))
                }
              : ImageLoader(
                  image: image!,
                  boxFit: BoxFit.cover,
                ),
        ).animate().fade(duration: const Duration(seconds: 1)),
      ),
    );
  }
}
