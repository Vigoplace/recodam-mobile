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
            onTap: () => Share.share('Recodam'),
            paddingLeft: 16,
          ),
          PopupMenuButton(
            color: AppColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            offset: const Offset(0, 60),
            itemBuilder: (context) =>
                ['Summary', 'Generate report', 'Delete book', 'Close book']
                    .map(
                      (e) => PopupMenuItem(
                        child: Text(
                          e,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColor.grey100,
                          ),
                        ),
                      ),
                    )
                    .toList(),
            child: const RoundIconButton(
              icon: AppSvg.moreVert,
              paddingLeft: 16,
            ),
          ),
        ],
      ),
      floatingActionButton: AppButton(
        text: 'Add record',
        onTap: () => context.pushNamed(
          CreateRecordScreen.name,
          extra: Create(
            bookId: CreateRecordModel(
              id: widget.book.id,
              name: widget.book.name,
            ),
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
