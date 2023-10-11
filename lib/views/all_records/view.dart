part of 'controller.dart';

class AllRecordsView
    extends StatelessView<AllRecordsScreen, AllRecordsController> {
  const AllRecordsView(AllRecordsController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'All records',
      ),
      backgroundColor: AppColor.grey,
      body: Column(
        children: [
          Container(
            color: AppColor.white,
            padding: [16, 20].pad,
            child: CustomTextInput(
              hintText: 'Search for book',
              fillColor: AppColor.grey,
              controller: controller.search,
              prefix: const SvgButton(
                icon: AppSvg.blackSearch,
              ),
            ),
          ),
          Expanded(
            child: Records(
              pagination: controller.pagination,
              searchWord: controller.search,
            ),
          ),
        ],
      ),
    );
  }
}
