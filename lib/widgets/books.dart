import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';

class Books extends ConsumerStatefulWidget {
  final Pagination pagination;
  final void Function(Book)? onTap;
  const Books({
    super.key,
    required this.pagination,
    this.onTap,
  });

  @override
  ConsumerState<Books> createState() => _BooksState();
}

class _BooksState extends ConsumerState<Books> {
  late Pagination pagination;
  late RefreshController refreshController;

  late FutureProviderFamily<List<Book>, Pagination> booksProvider;

  @override
  void initState() {
    super.initState();
    pagination = widget.pagination;
    booksProvider = FutureProvider.family(
      (ref, Pagination pagination) =>
          GetRequest.getAllBooks(pagination: pagination),
    );
    refreshController = RefreshController();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var books = ref.watch(booksProvider(pagination));
    return books.when(
      skipLoadingOnRefresh: false,
      data: (data) {
        return SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          onLoading: () async {
            if (data.length != pagination.total) {
              try {
                var a = await GetRequest.getAllBooks(
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
              var a = await GetRequest.getAllBooks(pagination: pagination);
              data.addAll(a);
              setState(() {});
              ();
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
                  padding: [0, 30, 0, 0].pad,
                  itemCount: data.length,
                  separatorBuilder: (context, index) => 15.verticalSpace,
                  itemBuilder: (context, index) {
                    var book = data[index];
                    return HorizBookCard(
                      book: book,
                      onTap: widget.onTap,
                    );
                  },
                ),
        );
      },
      error: (error, trace) {
        error as DioException;
        return ErrorScreen(
          error: error,
          reload: () => ref.invalidate(booksProvider),
        );
      },
      loading: () => const CustomLoader(),
    );
  }
}
