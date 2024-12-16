part of 'controller.dart';

class AllBooksView extends StatelessView<AllBooksScreen, AllBooksController> {
  const AllBooksView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      body: NestedScrollView(
        headerSliverBuilder: (context, isHead) {
          return [
            SliverAppBar(
              backgroundColor: AppColor.white,
              leading: RoundIconButton(
                icon: AppSvg.directionRight,
                onTap: () => context.pop(),
                paddingLeft: 16,
              ),
              centerTitle: true,
              leadingWidth: 80,
              title: Text(
                'All books',
                style: TextStyle(
                  color: AppColor.grey100,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.spMin,
                ),
              ),
            ),
          ];
        },
        body: Column(
          children: [
            50.verticalSpacing,
            Padding(
              padding: [15].pad,
              child: CustomTextInput(
                controller: controller.search,
                hintText: 'Seach for book',
              ),
            ),
            Expanded(
              child: Books(
                pagination: controller.pagination,
                searchWord: controller.search,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
