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
      body: Records(
        pagination: controller.pagination,
      ),
    );
  }
}
