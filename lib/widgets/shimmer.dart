import 'package:recordam/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class HomeBookShimmer extends StatelessWidget {
  const HomeBookShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      margin: EdgeInsets.only(left: 16.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: [16, 16].pad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          23.verticalSpace,
          ShimmerText(
            width: 120.w,
          ),
          23.verticalSpace,
          ShimmerText(
            width: 110.w,
          ),
          23.verticalSpace,
          const ShimmerText(),
          const Spacer(),
          ShimmerText(
            width: 50.w,
            height: 50.h,
            radius: 10.r,
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
        height: height ?? 12.h,
        width: width ?? 100.w,
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
      height: 150.h,
      margin: EdgeInsets.only(bottom: 16.w, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: [16, 16].pad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerText(
                width: 120.w,
              ),
              ShimmerText(
                width: 80.w,
              ),
            ],
          ),
          20.verticalSpace,
          ShimmerText(
            width: 150.w,
          ),
          const Spacer(),
          ShimmerText(
            width: 200.w,
          ),
        ],
      ),
    );
  }
}
