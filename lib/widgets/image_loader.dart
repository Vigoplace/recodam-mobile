import 'package:extended_image/extended_image.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/utils.dart';

class ImageLoader extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? boxFit;
  final BoxShape? boxShape;
  const ImageLoader({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.boxFit,
    this.boxShape,
    this.radius,
  });
  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      image,
      fit: BoxFit.fill,
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(8),
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Shimmer.fromColors(
              baseColor: AppColor.red60,
              highlightColor: AppColor.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Image.asset(AppImages.iconLogo),
              ),
            );
          case LoadState.completed:
            return ClipRRect(
              borderRadius: boxShape == BoxShape.circle
                  ? BorderRadius.circular(100.r)
                  : BorderRadius.zero,
              child: ExtendedRawImage(
                image: state.extendedImageInfo?.image,
                fit: boxFit,
              ),
            );
          case LoadState.failed:
            return GestureDetector(
              child: Center(
                child: Icon(
                  Icons.replay_outlined,
                  color: AppColor.red60,
                  size: 60,
                ),
              ),
              onTap: () => state.reLoadImage(),
            );
        }
      },
    );
  }
}
