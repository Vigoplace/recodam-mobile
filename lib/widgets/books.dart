import 'dart:async';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';

class Books extends ConsumerStatefulWidget {
  final Pagination pagination;
  final bool mini;
  final TextEditingController? searchWord;
  final void Function(Book)? onTap;
  final double? space;
  final int? id;
  final int? filterBook;
  final double? topMargin;
  const Books({
    super.key,
    required this.pagination,
    this.mini = false,
    this.onTap,
    this.searchWord,
    this.space,
    this.topMargin,
    this.id,
    this.filterBook,
  });

  @override
  ConsumerState<Books> createState() => _BooksState();
}

class _BooksState extends ConsumerState<Books> {
  late Pagination pagination;
  late RefreshController refreshController;
  late FutureProviderFamily<List<Book>, Pagination> booksProvider;
  ValueNotifier<List<Book>> bookList = ValueNotifier([]);
  bool _loaded = false;
  Timer? _debounce;
  String _textTracker = '';

  @override
  void initState() {
    super.initState();
    pagination = widget.pagination..page = 1;
    pagination.id = widget.id;
    booksProvider = FutureProvider.family(
      (ref, Pagination pagination) =>
          GetRequest.instance.getAllBooks(pagination: pagination),
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
    if (!mounted) return;
    _debounce = Timer(const Duration(seconds: 1), () {
      pagination
        ..page = 1
        ..search = widget.searchWord!.text;
      if (_textTracker != widget.searchWord?.text) {
        ref.invalidate(booksProvider(pagination));
        _textTracker = widget.searchWord!.text;
      }
      _loaded = false;
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
        if (!_loaded) {
          bookList.value = data.toList();
        }

        /// Do not include a particular book

        if (widget.filterBook != null) {
          bookList.value = bookList.value
              .where((element) => element.id != widget.filterBook)
              .toList();
        }
        _loaded = true;
        return ValueListenableBuilder(
          valueListenable: bookList,
          builder: (context, list, _) {
            return SmartRefresher(
              controller: refreshController,
              enablePullUp: true,
              onLoading: () async {
                if (list.length != pagination.total) {
                  try {
                    var a = await GetRequest.instance.getAllBooks(
                      pagination: pagination,
                    );
                    bookList.value = [...bookList.value, ...a];
                    refreshController.loadComplete();
                  } catch (_) {
                    refreshController.loadFailed();
                  }
                } else {
                  refreshController.loadNoData();
                  return;
                }
              },
              onRefresh: () async {
                bookList.value.clear();
                pagination.page = 1;
                try {
                  var a = await GetRequest.instance
                      .getAllBooks(pagination: pagination);
                  bookList.value = [...a];
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
                      padding: [0, widget.topMargin ?? 30, 0, 0].pad,
                      itemCount: list.length,
                      separatorBuilder: (context, index) =>
                          (widget.space ?? 15).verticalSpacing,
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
      error: (error, trace) => ErrorScreen(
        error: error,
        trace: trace,
        reload: () => ref.invalidate(booksProvider),
      ),
      loading: () => const Center(child: CustomLoader()),
    );
  }
}
