import 'package:recordam/utils/utils.dart';

class ViewImage extends StatefulWidget {
  final String image;
  const ViewImage({
    super.key,
    required this.image,
  });

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        centerTitle: false,
        title: 'Transaction Proof',
      ),
      backgroundColor: AppColor.grey,
      body: InteractiveViewer(
        child: Center(
          child: ImageLoader(
            image: widget.image,
            boxFit: BoxFit.fill,
          ).animate().fade(duration: const Duration(seconds: 1)),
        ),
      ),
    );
  }
}
