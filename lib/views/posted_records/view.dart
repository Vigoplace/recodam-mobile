part of 'controller.dart';

class PostedRecordsView
    extends StatelessView<PostedRecordsScreen, PostedRecordsController> {
  const PostedRecordsView(PostedRecordsController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    var books =
        controller.ref.watch(controller.booksProvider(controller.pagination));
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: const CustomAppbar(
        title: 'Posted records',
        centerTitle: false,
      ),
      body: books.when(
        skipLoadingOnRefresh: false,
        data: (data) {
          return SmartRefresher(
            controller: controller.refreshController,
            enablePullUp: true,
            onLoading: () async {
              if (data.length != controller.pagination.total) {
                try {
                  var a = await GetRequest.testPagination(
                    pagination: controller.pagination,
                  );
                  data.addAll(a);
                  controller.refreshController.loadComplete();
                  controller.reload();
                } catch (_) {
                  controller.refreshController.loadFailed();
                }
              } else {
                controller.refreshController.loadNoData();
                return;
              }
            },
            onRefresh: () async {
              data.clear();
              controller.pagination.page = 1;
              try {
                var a = await GetRequest.testPagination(
                    pagination: controller.pagination);
                data.addAll(a);
                controller.reload();
                controller.refreshController
                    .refreshCompleted(resetFooterState: true);
              } catch (_) {
                controller.refreshController.refreshFailed();
              }
            },
            child: data.isEmpty
                ? const EmptyWidget(
                    text: 'Nothing to see here',
                  )
                : ListView.builder(
                    padding: [0, 30, 0, 0].pad,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return const RecordCard();
                    },
                  ),
          );
        },
        error: (error, trace) {
          error as DioException;
          return ErrorScreen(
            error: error,
            reload: () => controller.ref.invalidate(controller.booksProvider),
          );
        },
        loading: () => const CustomLoader(),
      ),
    );
  }
}
