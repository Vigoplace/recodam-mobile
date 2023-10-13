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
        title: 'Recently viewed books',
      ),
      body: books.when(
        data: (data) => data.keys.toList().isNotEmpty
            ? GroupedListView<List<Book>, DateTime>(
                elements: data.values.toList(),
                groupBy: (element) => element[0].viewed!,
                order: GroupedListOrder.DESC,
                groupSeparatorBuilder: (DateTime groupByValue) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    30.verticalSpace,
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        groupByValue.formattedDate(),
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
                itemBuilder: (context, element) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      element.map((book) => BookCardMini(book: book)).toList(),
                ),
              )
            : const EmptyWidget(
                text: 'Nothing to see here',
              ),
        error: (error, trace) {
          error as DioException;
          return ErrorScreen(
            error: error,
            reload: () => controller.ref.invalidate(controller.allBooks),
          );
        },
        loading: () => const CustomLoader(),
      ),
    );
  }
}
