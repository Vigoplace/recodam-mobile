import 'package:recordam/utils/utils.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: [0, 0, 0, 1.5].pad,
      decoration: BoxDecoration(
        color: AppColor.red60,
        borderRadius: BorderRadius.circular(8.r),
      ),
      width: 220.w,
      margin: [0, 0, 16, 0].pad,
      child: Container(
        padding: [16, 23].pad,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "School Donations",
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            21.verticalSpace,
            Row(
              children: [
                SvgPicture.asset(
                  AppSvg.rect,
                ),
                16.horizontalSpace,
                Text(
                  "N10,000",
                  style: TextStyle(
                    color: AppColor.grey100,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                )
              ],
            ),
            16.verticalSpace,
            Row(
              children: [
                SvgPicture.asset(
                  AppSvg.clock,
                ),
                16.horizontalSpace,
                Text(
                  "2 days ago",
                  style: TextStyle(
                    color: AppColor.grey100,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                )
              ],
            ),
            const Spacer(),
            Row(
              children: [
                SvgPicture.asset(
                  AppSvg.card,
                ),
                6.horizontalSpace,
                Text(
                  "12",
                  style: TextStyle(
                    color: AppColor.grey100,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
