part of 'controller.dart';

class AllBooksView extends StatelessView<AllBooksScreen, AllBooksController> {
  const AllBooksView(AllBooksController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'All books',
      ),
      body: Books(
        pagination: controller.pagination,
      ),
    );
  }
}
