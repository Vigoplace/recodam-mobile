part of 'controller.dart';

class AllBooksView extends StatelessView<AllBooksScreen, AllBooksController> {
  const AllBooksView(AllBooksController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    var books = controller.ref.watch(controller.allBooks);
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: const CustomAppbar(
        title: 'All books',
      ),
      body: books.when(
        data: (data) {
          controller.holder.addAll(data);
          return controller.holder.keys.toList().isNotEmpty
              ? SmartRefresher(
                  controller: controller.refreshController,
                  enablePullUp: true,
                  onLoading: () async {
                    if (controller.holder.values
                            .expand((innerList) => innerList)
                            .length !=
                        controller.pagination.total) {
                      try {
                        var a = await GetRequest.instance.getGroupedBooks(
                          pagination: controller.pagination,
                        );
                        controller.holder.addAll(a);
                        controller.refreshController.loadComplete();
                        controller.reload();
                      } catch (_) {
                        controller.refreshController.refreshFailed();
                      }
                    } else {
                      controller.refreshController.loadNoData();
                      return;
                    }
                  },
                  onRefresh: () async {
                    controller.holder.clear();
                    controller.pagination.lastDate = null;
                    try {
                      var a = await GetRequest.instance.getGroupedBooks(
                        pagination: controller.pagination,
                      );
                      controller.holder.addAll(a);
                      controller.reload();
                      controller.refreshController
                          .refreshCompleted(resetFooterState: true);
                    } catch (_) {
                      controller.refreshController.refreshFailed();
                    }
                  },
                  child: ListView.builder(
                    padding: [0, 20, 0, 0].pad,
                    itemCount: controller.holder.keys.length,
                    itemBuilder: (context, index) {
                      var x = (controller.holder.keys.toList()[index]);
                      var book = controller.holder[x]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.verticalSpace,
                              Padding(
                                padding: EdgeInsets.only(left: 20.w),
                                child: Text(
                                  x.formattedDate(),
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
                          Column(
                            children:
                                book.map((e) => BookCardMini(book: e)).toList(),
                          ),
                        ],
                      );
                    },
                  ),
                )
              : const EmptyWidget(
                  text: 'Nothing to see here',
                );
        },
        error: (error, trace) => ErrorScreen(
          error: error,
          trace: trace,
          reload: () => controller.ref.invalidate(controller.allBooks),
        ),
        loading: () => const CustomLoader(),
      ),
    );
  }
}
