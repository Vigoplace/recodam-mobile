import 'dart:async';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';

class Books extends ConsumerStatefulWidget {
  final Pagination pagination;
  final bool mini;
  final TextEditingController? searchWord;
  final void Function(Book)? onTap;
  const Books({
    super.key,
    required this.pagination,
    this.mini = false,
    this.onTap,
    this.searchWord,
  });

  @override
  ConsumerState<Books> createState() => _BooksState();
}

class _BooksState extends ConsumerState<Books> {
  late Pagination pagination;
  late RefreshController refreshController;
  late FutureProviderFamily<List<Book>, Pagination> booksProvider;
  ValueNotifier<List<Book>> bookList = ValueNotifier([]);
  List<Book> holderList = [];
  bool loaded = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    pagination = widget.pagination..page = 1;
    booksProvider = FutureProvider.family(
      (ref, Pagination pagination) =>
          GetRequest.getAllBooks(pagination: pagination),
    );
    refreshController = RefreshController();
    widget.searchWord?.addListener(() {
      if (widget.searchWord != null && widget.searchWord!.text.isNotEmpty) {
        _onSearchTextChanged(widget.searchWord!.text);
      }
    });
    if (widget.searchWord != null && widget.searchWord!.text.isNotEmpty) {
      _onSearchTextChanged(widget.searchWord!.text, seconds: 0);
    }
  }

  void _onSearchTextChanged(String query, {int seconds = 1}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      pagination
        ..page = 1
        ..search = widget.searchWord!.text;
      ref.invalidate(booksProvider(pagination));
      loaded = false;
    });
  }

  @override
  void dispose() {
    refreshController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var books = ref.watch(booksProvider(pagination));
    return books.when(
      skipLoadingOnRefresh: false,
      data: (data) {
        if (!loaded) {
          bookList.value = data.toList();
        }
        loaded = true;
        holderList = data.toList();
        return ValueListenableBuilder(
          valueListenable: bookList,
          builder: (context, list, _) {
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
              child: list.isEmpty
                  ? const EmptyWidget(
                      text: 'Nothing to see here',
                    )
                  : ListView.separated(
                      padding: [0, 30, 0, 0].pad,
                      itemCount: list.length,
                      separatorBuilder: (context, index) => 15.verticalSpace,
                      itemBuilder: (context, index) {
                        var book = list[index];
                        return widget.mini
                            ? BookCardMini(
                                book: book,
                                onTap: widget.onTap,
                              )
                            : HorizBookCard(
                                book: book,
                                onTap: widget.onTap,
                              );
                      },
                    ),
            );
          },
        );
      },
      error: (error, trace) {
        error as DioException;
        return ErrorScreen(
          error: error,
          reload: () => ref.invalidate(booksProvider),
        );
      },
      loading: () => const Center(child: CustomLoader()),
    );
  }
}
