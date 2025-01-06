import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/extension/context_extension.dart';
import 'package:recordam/utils/utils.dart';

class RecordCard extends ConsumerWidget {
  final Record record;
  final DetailType detailType;
  final RefreshController? refreshController;
  const RecordCard({
    super.key,
    required this.record,
    required this.detailType,
    this.refreshController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        var rec = await context.pushTo(
          RecordScreen(
            info: ViewRecordInfo(
              record: record,
              type: detailType,
            ),
          ),
        );
        if (rec != null && refreshController != null) {
          refreshController!.requestRefresh();
        }
      },
      overlayColor: WidgetStateColor.transparent,
      child: Container(
        padding: [20, 22].pad,
        margin: [16, 0, 16, 16].pad,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      bool isSender = record.owner?.myRecord == true;
                      return TextScroll(
                        'From: ${isSender ? 'Me' : record.owner?.name}',
                        velocity: AppConstant.velocity,
                        style: TextStyle(
                          color: AppColor.grey100,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.spMin,
                        ),
                      );
                    },
                  ),
                ),
                10.horizontalSpacing,
                Text(
                  '${record.symbol}${record.amount}',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: AppColor.grey100,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.spMin,
                  ),
                ),
              ],
            ),
            4.verticalSpacing,
            if (record.receiver != null)
              Row(
                children: [
                  Text(
                    'To: ',
                    style: TextStyle(
                      color: AppColor.grey100,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.spMin,
                    ),
                  ),
                  5.horizontalSpacing,
                  Expanded(
                    child: TextScroll(
                      record.receiver?.name ?? '',
                      velocity: AppConstant.velocity,
                      style: TextStyle(
                        color: AppColor.grey100,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.spMin,
                      ),
                    ),
                  ),
                ],
              ),
            23.verticalSpacing,
            TextScroll(
              record.details,
              velocity: AppConstant.velocity,
              style: TextStyle(
                color: AppColor.grey40,
                fontWeight: FontWeight.w400,
                fontSize: 14.spMin,
              ),
            ),
          ],
        ),
      ).animate().moveX(),
    );
  }
}
