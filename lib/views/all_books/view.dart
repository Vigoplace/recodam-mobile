part of 'controller.dart';

class AllBooksView extends StatelessView<AllBooksScreen, AllBooksController> {
  const AllBooksView(AllBooksController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: const CustomAppbar(
        title: 'All books',
      ),
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
            child: Books(
              searchWord: controller.search,
              pagination: controller.pagination,
            ),
          ),
        ],
      ),
    );
  }
}
