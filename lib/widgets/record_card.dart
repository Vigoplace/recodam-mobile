import 'package:recordam/utils/utils.dart';

class RecordCard extends StatelessWidget {
  final Record record;
  const RecordCard({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(
        RecordScreen.name,
        extra: record,
      ),
      child: Container(
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
                  record.senderName,
                  style: TextStyle(
                    color: AppColor.grey100,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  '${record.symbol}${record.amount}',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: AppColor.grey100,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            8.verticalSpace,
            Text(
              (record.bankName == null || record.bankName!.isEmpty)
                  ? 'No bank name'
                  : record.bankName!,
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 11.sp,
              ),
            ),
            23.verticalSpace,
            Text(
              record.details,
              style: TextStyle(
                color: AppColor.grey40,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ).animate().moveX(),
    );
  }
}
