import 'dart:async';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/utils/utils.dart';

class Records extends ConsumerStatefulWidget {
  final Pagination pagination;
  final void Function(Book)? onTap;
  final TextEditingController? searchWord;
  final RecordSearchType recordSearchType;
  final void Function(RefreshController)? onCreate;
  const Records({
    super.key,
    required this.pagination,
    this.searchWord,
    this.onTap,
    this.onCreate,
    this.recordSearchType = RecordSearchType.all,
  });

  @override
  ConsumerState<Records> createState() => _BooksState();
}

class _BooksState extends ConsumerState<Records> {
  late Pagination pagination;
  late RefreshController refreshController;
  ValueNotifier<List<Record>> recordList = ValueNotifier([]);
  late FutureProviderFamily<List<Record>, Pagination> recordsProvider;
  bool _loaded = false;
  Timer? _debounce;
  String _textTracker = '';

  @override
  void initState() {
    super.initState();
    pagination = widget.pagination..page = 1;
    recordsProvider = FutureProvider.family(
      (ref, Pagination pagination) {
        return switch (widget.recordSearchType) {
          RecordSearchType.all =>
            GetRequest.instance.getRecords(pagination: pagination),
          _ => GetRequest.instance.getHomeRecords(pagination: pagination),
        };
      },
    );
    refreshController = RefreshController();
    if (widget.onCreate != null) {
      widget.onCreate!(refreshController);
    }

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
      if (_textTracker != widget.searchWord!.text) {
        ref.invalidate(recordsProvider(pagination));
        _textTracker = widget.searchWord!.text;
      }
      _loaded = false;
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
        if (!_loaded) {
          recordList.value = data.toList();
        }
        _loaded = true;
        return ValueListenableBuilder(
          valueListenable: recordList,
          builder: (context, list, _) {
            return SmartRefresher(
              controller: refreshController,
              enablePullUp: true,
              onLoading: () async {
                if (list.length != pagination.total) {
                  try {
                    var a = await GetRequest.instance.getRecords(
                      pagination: pagination,
                    );
                    recordList.value.addAll(a);
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
                recordList.value.clear();
                pagination.page = 1;
                try {
                  var a = await GetRequest.instance
                      .getRecords(pagination: pagination);
                  recordList.value.addAll(a);
                  setState(() {});
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
                          detailType: DetailType.view,
                          refreshController: refreshController,
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
        reload: () => ref.invalidate(recordsProvider),
      ),
      loading: () => const CustomLoader(),
    );
  }
}
