part of 'controller.dart';

class AllRecordsView
    extends StatelessView<AllRecordsScreen, AllRecordsController> {
  const AllRecordsView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      body: NestedScrollView(
        headerSliverBuilder: (context, isHead) {
          return [
            SliverAppBar(
              backgroundColor: AppColor.white,
              leading: RoundIconButton(
                icon: AppSvg.directionRight,
                onTap: () => context.pop(),
                paddingLeft: 16,
              ),
              centerTitle: true,
              leadingWidth: 80.w,
              title: Text(
                'All records',
                style: TextStyle(
                  color: AppColor.grey100,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ];
        },
        body: Column(
          children: [
            50.verticalSpace,
            Padding(
              padding: [15].pad,
              child: CustomTextInput(
                controller: controller.search,
                hintText: 'Seach for records',
              ),
            ),
            Expanded(
              child: Records(
                pagination: controller.pagination,
                searchWord: controller.search,
                recordSearchType: RecordSearchType.noBook,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
