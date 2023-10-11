import 'package:recordam/utils/utils.dart';

class ViewImage extends StatelessWidget {
  final String? image;
  final String appBarText;
  const ViewImage({
    super.key,
    required this.image,
    required this.appBarText,
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
          child: (image == null || image!.isEmpty)
              ? Image.asset(AppImages.image)
              : ImageLoader(
                  image: image!,
                  boxFit: BoxFit.fill,
                ).animate().fade(duration: const Duration(seconds: 1)),
        ),
      ),
    );
  }
}
