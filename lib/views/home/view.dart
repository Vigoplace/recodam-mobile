part of 'controller.dart';

class HomeView extends StatelessView<HomeScreen, HomeController> {
  const HomeView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      body: Stack(
        children: [
          CustomScrollView(
            cacheExtent: 1000,
            slivers: [
              SliverAppBar(
                backgroundColor: AppColor.white,
                centerTitle: false,
                floating: true,
                snap: true,
                title: TextScroll(
                  'Welcome ${controller.ref.watch(nameProvider)}',
                  velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
                  style: TextStyle(
                    color: AppColor.grey100,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.spMin,
                  ),
                ),
                actions: [
                  InkWell(
                    child: Center(
                      child: Consumer(
                        builder: (context, ref, _) {
                          var photo = ref.watch(profilePhotoProvider);
                          return (photo == null || photo.isEmpty)
                              ? Image.asset(
                                  AppImages.image,
                                )
                              : ImageLoader(
                                  width: 40,
                                  height: 40,
                                  image: photo,
                                  boxShape: BoxShape.circle,
                                  boxFit: BoxFit.cover,
                                );
                        },
                      ),
                    ),
                    onTap: () => context.pushNamed(ProfileScreen.name),
                  ),
                  10.horizontalSpacing,
                ],
              ),
              SliverList.list(
                children: [
                  29.verticalSpacing,
                  Padding(
                    padding: const [16, 0].pad,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Books',
                          style: TextStyle(
                            color: AppColor.grey70,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.spMin,
                          ),
                        ),
                        InkWell(
                          overlayColor: WidgetStateColor.transparent,
                          onTap: () => context.pushNamed(AllBooksScreen.name),
                          child: Text(
                            'See all',
                            style: TextStyle(
                              color: AppColor.red60,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.spMin,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  18.verticalSpacing,
                  SizedBox(
                    height: 300,
                    child: SmartRefresher(
                      controller: controller.refreshController,
                      scrollDirection: Axis.horizontal,
                      onRefresh: () {
                        controller.ref.invalidate(homeBookProvider);
                        controller.refreshController.refreshCompleted();
                      },
                      child: Consumer(
                        builder: (context, ref, _) {
                          var books = ref.watch(homeBookProvider);
                          return books.when(
                            data: (data) => data.isEmpty
                                ? const EmptyWidget(
                                    text: 'Nothing to see here',
                                  )
                                : ListView.builder(
                                    itemCount: data.length,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(left: 16),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      var book = data[index];
                                      return BookCard(book: book);
                                    },
                                  ),
                            error: (error, trace) => ErrorScreen(
                              error: error,
                              trace: trace,
                              reload: () => ref.invalidate(homeBookProvider),
                            ),
                            loading: () => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (int i = 0; i <= 3; i++)
                                    const HomeBookShimmer(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  34.verticalSpacing,
                  Padding(
                    padding: const [16, 0].pad,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Records',
                          style: TextStyle(
                            color: AppColor.grey70,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.spMin,
                          ),
                        ),
                        InkWell(
                          overlayColor: WidgetStateColor.transparent,
                          onTap: () => context.pushNamed(AllRecordsScreen.name),
                          child: Text(
                            'See all',
                            style: TextStyle(
                              color: AppColor.red60,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.spMin,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  18.verticalSpacing,
                  Consumer(
                    builder: (context, ref, _) {
                      var record = ref.watch(homeRecordProvider);
                      return record.when(
                        data: (data) => data.isEmpty
                            ? Column(
                                children: [
                                  30.verticalSpacing,
                                  const EmptyWidget(
                                    text: 'Nothing to see here',
                                  ),
                                ],
                              )
                            : Column(
                                children: data
                                    .map((e) => RecordCard(
                                          record: e,
                                          detailType: DetailType.view,
                                        ))
                                    .toList(),
                              ),
                        error: (error, trace) => ErrorScreen(
                          error: error,
                          trace: trace,
                          reload: () => ref.invalidate(homeRecordProvider),
                        ),
                        loading: () => SingleChildScrollView(
                          child: Column(
                            children: [
                              for (int i = 0; i <= 3; i++)
                                const HomeRecordShimmer(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  150.verticalSpacing,
                ],
              ),
            ],
          ),
          const CustomBottomNavbar(),
        ],
      ),
    );
  }
}
