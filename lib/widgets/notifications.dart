import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';
import 'package:recordam/widgets/notification_card.dart';

class Notifications extends ConsumerStatefulWidget {
  final void Function(Book)? onTap;
  final RefreshController refreshController;
  const Notifications({
    super.key,
    this.onTap,
    required this.refreshController,
  });

  @override
  ConsumerState<Notifications> createState() => _BooksState();
}

class _BooksState extends ConsumerState<Notifications> {
  late Pagination pagination;
  late RefreshController refreshController;
  late FutureProviderFamily<List<NotificationMessage>, Pagination>
      notificationsProvider;

  @override
  void initState() {
    super.initState();
    pagination = Pagination();
    notificationsProvider = FutureProvider.family(
        (ref, Pagination pagination) =>
            GetRequest.instance.getNotifications(pagination: pagination));
    refreshController = widget.refreshController;
  }

  @override
  Widget build(BuildContext context) {
    var books = ref.watch(notificationsProvider(pagination));
    return books.when(
      skipLoadingOnRefresh: false,
      data: (data) {
        return SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          onLoading: () async {
            if (data.length != pagination.total) {
              try {
                var a = await GetRequest.instance.getNotifications(
                  pagination: pagination,
                );
                data.addAll(a);
                refreshController.loadComplete();
                setState(() {});
              } catch (_) {
                refreshController.loadFailed();
              }
            } else {
              refreshController.loadNoData();
              return;
            }
          },
          onRefresh: () async {
            data.clear();
            pagination.page = 1;
            try {
              var a = await GetRequest.instance
                  .getNotifications(pagination: pagination);
              data.addAll(a);
              setState(() {});
              refreshController.refreshCompleted(resetFooterState: true);
            } catch (_) {
              refreshController.refreshFailed();
            }
          },
          child: data.isEmpty
              ? const EmptyWidget(
                  text: 'Nothing to see here',
                )
              : ListView.separated(
                  padding: [20, 30, 20, 0].pad,
                  itemCount: data.length,
                  separatorBuilder: (context, index) => 15.verticalSpacing,
                  itemBuilder: (context, index) {
                    var notification = data[index];
                    return NotificationCard(
                      notification: notification,
                    );
                  },
                ),
        );
      },
      error: (error, trace) => ErrorScreen(
        error: error,
        trace: trace,
        reload: () => ref.invalidate(notificationsProvider),
      ),
      loading: () => const CustomLoader(),
    );
  }
}
