part of 'controller.dart';

class ViewBookView extends StatelessView<ViewBookScreen, ViewBookController> {
  const ViewBookView(ViewBookController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: CustomAppbar(
        title: widget.book.name,
        centerTitle: false,
        action: [
          RoundIconButton(
            icon: AppSvg.share,
            onTap: () {},
            paddingLeft: 16,
          ),
          RoundIconButton(
            icon: AppSvg.moreVert,
            onTap: () {},
            paddingLeft: 16,
          ),
        ],
      ),
      floatingActionButton: AppButton(
        text: 'Add record',
        onTap: () => context.pushNamed(
          CreateRecordScreen.name,
          extra: CreateRecordModel(
            id: widget.book.id,
            name: widget.book.name,
          ),
        ),
        width: 150.w,
        icon: SvgPicture.asset(AppSvg.record),
      ),
      body: Column(
        children: [
          Container(
            color: AppColor.white,
            padding: [16, 20].pad,
            child: CustomTextInput(
              hintText: 'Search',
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
