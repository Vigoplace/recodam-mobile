import 'package:recordam/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class HomeBookShimmer extends StatelessWidget {
  const HomeBookShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: [16, 16].pad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          23.verticalSpacing,
          const ShimmerText(
            width: 120,
          ),
          23.verticalSpacing,
          const ShimmerText(
            width: 110,
          ),
          23.verticalSpacing,
          const ShimmerText(),
          const Spacer(),
          const ShimmerText(
            width: 50,
            height: 50,
            radius: 10,
          ),
        ],
      ),
    );
  }
}

class ShimmerText extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  const ShimmerText({
    super.key,
    this.height,
    this.radius,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.red30.withOpacity(0.2),
      period: const Duration(seconds: 5),
      highlightColor: AppColor.grey,
      child: Container(
        height: height ?? 12,
        width: width ?? 100,
        decoration: ShapeDecoration(
          color: AppColor.red30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 0),
          ),
        ),
      ),
    );
  }
}

class HomeRecordShimmer extends StatelessWidget {
  const HomeRecordShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: [16, 16].pad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerText(
                width: 120,
              ),
              ShimmerText(
                width: 80,
              ),
            ],
          ),
          20.verticalSpacing,
          const ShimmerText(
            width: 150,
          ),
          const Spacer(),
          const ShimmerText(
            width: 200,
          ),
        ],
      ),
    );
  }
}
