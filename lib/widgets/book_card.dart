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
              style: CustomTextStyle.text700_14.withColor(
                AppColor.grey100,
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
                  style: CustomTextStyle.text400_14.withColor(
                    AppColor.grey100,
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
                  style: CustomTextStyle.text400_14.withColor(
                    AppColor.grey100,
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
                  style: CustomTextStyle.text400_12.withColor(
                    AppColor.grey100,
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
