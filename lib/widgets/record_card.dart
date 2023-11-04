import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';

class RecordCard extends ConsumerWidget {
  final Record record;
  final RefreshController? refreshController;
  const RecordCard({
    super.key,
    required this.record,
    this.refreshController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        PostRequest.instance
            .updateRecordView(bookId: record.id)
            .catchError((error) => '');
        var rec = await context.pushNamed<CreateRecord?>(
          RecordScreen.name,
          extra: ViewRecordInfo(
            record: record,
            type: DetailType.view,
          ),
        );
        if (rec != null && refreshController != null) {
          refreshController!.requestRefresh();
        }
      },
      overlayColor: MaterialStateColor.resolveWith(
        (states) => Colors.transparent,
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
                Builder(
                  builder: (context) {
                    bool isSender = record.myRecord;
                    return Text(
                      'From: ${isSender ? 'Me' : record.senderName}',
                      style: TextStyle(
                        color: AppColor.grey100,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    );
                  },
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
            4.verticalSpace,
            Text(
              (record.bankName == null || record.bankName!.isEmpty)
                  ? 'Cash'
                  : record.bankName!,
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 11.sp,
              ),
            ),
            10.verticalSpace,
            if (!record.myRecord)
              Builder(builder: (context) {
                return Text(
                  'To: ${record.senderName}',
                  style: TextStyle(
                    color: AppColor.grey100,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                );
              }),
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
