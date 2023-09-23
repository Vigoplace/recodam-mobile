import 'package:recordam/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class HomeBookShimmer extends StatelessWidget {
  const HomeBookShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.grey1,
      period: const Duration(seconds: 5),
      highlightColor: AppColor.red30.withOpacity(0.1),
      child: Container(
        width: 220.w,
        margin: EdgeInsets.only(left: 16.w),
        decoration: BoxDecoration(
          color: AppColor.red60,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}

class HomeRecordShimmer extends StatelessWidget {
  const HomeRecordShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.grey1,
      period: const Duration(seconds: 5),
      highlightColor: AppColor.red30.withOpacity(0.1),
      child: Container(
        height: 200.h,
        margin: EdgeInsets.only(bottom: 16.w, left: 16.w, right: 16.w),
        decoration: BoxDecoration(
          color: AppColor.red60,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
