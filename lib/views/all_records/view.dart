part of 'controller.dart';

class AllRecordsView
    extends StatelessView<AllRecordsScreen, AllRecordsController> {
  const AllRecordsView(AllRecordsController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    var records = controller.ref.watch(controller.allRecords);
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: const CustomAppbar(
        title: 'Recently viewed records',
      ),
      body: records.when(
        data: (data) => data.keys.toList().isNotEmpty
            ? GroupedListView<List<Record>, DateTime>(
                elements: data.values.toList(),
                groupBy: (element) => element[0].viewed!,
                order: GroupedListOrder.DESC,
                groupSeparatorBuilder: (DateTime groupByValue) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    30.verticalSpace,
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        groupByValue.formattedDate(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColor.grey100,
                        ),
                      ),
                    ),
                    20.verticalSpace,
                  ],
                ),
                itemBuilder: (context, element) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: element
                      .map((record) => RecordCard(record: record))
                      .toList(),
                ),
              )
            : const EmptyWidget(
                text: 'Nothing to see here',
              ),
        error: (error, trace) {
          error as DioException;
          return ErrorScreen(
            error: error,
            reload: () => controller.ref.invalidate(controller.allRecords),
          );
        },
        loading: () => const CustomLoader(),
      ),
    );
  }
}
