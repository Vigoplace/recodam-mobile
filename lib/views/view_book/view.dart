part of 'controller.dart';

class ViewBookView extends StatelessView<ViewBookScreen, ViewBookController> {
  const ViewBookView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      // appBar: CustomAppbar(
      //   title: widget.book.name,
      //   centerTitle: false,
      //   action: [
      //     RoundIconButton(
      //       icon: AppSvg.share,
      //       onTap: () => Share.share('Recodam'),
      //       paddingLeft: 16,
      //     ),
      //     PopupMenuButton(
      //       color: AppColor.white,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(8),
      //       ),
      //       offset: const Offset(0, 60),
      //       itemBuilder: (context) =>
      //           ['Summary', 'Generate report', 'Delete book', 'Close book']
      //               .map(
      //                 (e) => PopupMenuItem(
      //                   child: Text(
      //                     e,
      //                     style: TextStyle(
      //                       fontSize: 16,
      //                       fontWeight: FontWeight.w400,
      //                       color: AppColor.grey100,
      //                     ),
      //                   ),
      //                 ),
      //               )
      //               .toList(),
      //       child: const RoundIconButton(
      //         icon: AppSvg.moreVert,
      //         paddingLeft: 16,
      //       ),
      //     ),
      //   ],
      // ),
      floatingActionButton: AppButton(
        text: 'Add record',
        onTap: () async {
          var a = await context.pushTo<CreateRecord?>(
            CreateRecordScreen(
              create: Create(
                bookId: CreateRecordModel(
                  id: widget.book.id,
                  name: widget.book.name,
                  type: DetailType.add,
                  recordType: widget.book.type,
                ),
              ),
            ),
          );
          if (a != null) {
            controller.refreshController.requestRefresh();
          }
        },
        width: 150,
        icon: SvgPicture.asset(AppSvg.record),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, val) => [
          SliverAppBar(
            backgroundColor: AppColor.white,
            leading: RoundIconButton(
              icon: AppSvg.directionRight,
              onTap: () => context.pop(),
              paddingLeft: 16,
            ),
            centerTitle: false,
            leadingWidth: 80,
            title: Text(
              widget.book.name,
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 18.spMin,
              ),
            ),
            actions: [
              RoundIconButton(
                icon: AppSvg.share,
                onTap: () =>
                    SharePlus.instance.share(ShareParams(text: 'Recordam')),
                paddingLeft: 16,
              ),
              PopupMenuButton(
                color: AppColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
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
              16.horizontalSpacing,
            ],
          ),
        ],
        body: Column(
          children: [
            Container(
              color: AppColor.white,
              padding: [16, 20].pad,
              child: Column(
                children: [
                  25.verticalSpacing,
                  CustomTextInput(
                    hintText: 'Search',
                    fillColor: AppColor.grey,
                    controller: controller.search,
                    prefix: const SvgButton(
                      icon: AppSvg.blackSearch,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Records(
                pagination: controller.pagination,
                searchWord: controller.search,
                onCreate: (refreshController) {
                  controller.refreshController = refreshController;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
