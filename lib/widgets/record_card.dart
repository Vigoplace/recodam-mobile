import 'package:recordam/utils/utils.dart';

class RecordCard extends StatelessWidget {
  const RecordCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: [20, 22].pad,
      margin: [16, 0, 16, 16].pad,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Micheal Evans",
                style: CustomTextStyle.text700_14.withColor(
                  AppColor.grey100,
                ),
              ),
              Text(
                "N10,000",
                style: CustomTextStyle.text700_14.withColor(
                  AppColor.grey100,
                ),
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            "First Bank of Nigeria",
            style: CustomTextStyle.text700_11.withColor(
              AppColor.grey100,
            ),
          ),
          23.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Maryland school donation for kids.",
                style: CustomTextStyle.text400_14.withColor(
                  AppColor.grey40,
                ),
              ),
              RoundIconButton(
                icon: AppSvg.moreHoriz,
                onTap: () {},
              )
            ],
          ),
        ],
      ),
    );
  }
}
