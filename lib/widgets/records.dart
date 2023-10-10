import 'dart:async';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';

class Records extends ConsumerStatefulWidget {
  final Pagination pagination;
  final void Function(Book)? onTap;
  final TextEditingController? searchWord;
  const Records({
    super.key,
    required this.pagination,
    this.searchWord,
    this.onTap,
  });

  @override
  ConsumerState<Records> createState() => _BooksState();
}

class _BooksState extends ConsumerState<Records> {
  late Pagination pagination;
  late RefreshController refreshController;
  ValueNotifier<List<Record>> recordList = ValueNotifier([]);
  List<Record> holderList = [];
  late FutureProviderFamily<List<Record>, Pagination> recordsProvider;
  bool loaded = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    pagination = widget.pagination..page = 1;
    recordsProvider = FutureProvider.family(
      (ref, Pagination pagination) =>
          GetRequest.getRecords(pagination: pagination),
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
    _debounce = Timer(Duration(seconds: seconds), () {
      pagination
        ..page = 1
        ..search = widget.searchWord!.text;
      ref.invalidate(recordsProvider(pagination));
      loaded = false;
    });
  }

  @override
  void dispose() {
    refreshController.dispose();
    recordList.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var books = ref.watch(recordsProvider(pagination));
    return books.when(
      skipLoadingOnRefresh: false,
      data: (data) {
        if (!loaded) {
          recordList.value = data.toList();
        }
        loaded = true;
        holderList = data.toList();
        return ValueListenableBuilder(
          valueListenable: recordList,
          builder: (context, list, _) {
            return SmartRefresher(
              controller: refreshController,
              enablePullUp: true,
              onLoading: () async {
                if (data.length != pagination.total) {
                  try {
                    var a = await GetRequest.getRecords(
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
                  var a = await GetRequest.getRecords(pagination: pagination);
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
                        return RecordCard(
                          record: book,
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
          reload: () => ref.invalidate(recordsProvider),
        );
      },
      loading: () => const CustomLoader(),
    );
  }
}
