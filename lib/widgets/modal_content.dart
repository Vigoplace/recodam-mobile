import 'package:recordam/utils/utils.dart';

class SearchModalContent extends StatefulWidget {
  final TextEditingController searchController;
  const SearchModalContent({
    super.key,
    required this.searchController,
  });

  @override
  State<SearchModalContent> createState() => _SearchModalContentState();
}

class _SearchModalContentState extends State<SearchModalContent> {
  Pagination bookPagination = Pagination();
  Pagination recordPagination = Pagination();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.spMin,
            ),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: AppColor.red60,
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.spMin,
            ),
            labelColor: AppColor.grey100,
            unselectedLabelColor: AppColor.light90,
            tabs: const [
              Tab(
                text: 'Books',
              ),
              Tab(
                text: 'Records',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Books(
                  pagination: bookPagination,
                  searchWord: widget.searchController,
                  mini: true,
                ),
                Records(
                  pagination: recordPagination,
                  searchWord: widget.searchController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
