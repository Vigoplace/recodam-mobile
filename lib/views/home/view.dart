part of 'controller.dart';

class HomeView extends StatelessView<HomeScreen, HomeController> {
  const HomeView(HomeController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: AppConstant.key,
      backgroundColor: AppColor.grey,
      body: Stack(
        children: [
          CustomScrollView(
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
                    fontSize: 16.sp,
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
                  10.horizontalSpace,
                ],
              ),
              SliverList.list(
                children: [
                  29.verticalSpace,
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
                            fontSize: 14.sp,
                          ),
                        ),
                        InkWell(
                          overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent,
                          ),
                          onTap: () => context.pushNamed(AllBooksScreen.name),
                          child: Text(
                            'See all',
                            style: TextStyle(
                              color: AppColor.red60,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  18.verticalSpace,
                  SizedBox(
                    height: 300.h,
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
                                    padding: EdgeInsets.only(left: 16.w),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      var book = data[index];
                                      return BookCard(book: book);
                                    },
                                  ),
                            error: (error, trace) {
                              error as DioException;
                              return ErrorScreen(
                                error: error,
                                reload: () => ref.invalidate(homeBookProvider),
                              );
                            },
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
                  34.verticalSpace,
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
                            fontSize: 14.sp,
                          ),
                        ),
                        InkWell(
                          overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent,
                          ),
                          onTap: () => context.pushNamed(AllRecordsScreen.name),
                          child: Text(
                            'See all',
                            style: TextStyle(
                              color: AppColor.red60,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  18.verticalSpace,
                  Consumer(
                    builder: (context, ref, _) {
                      var record = ref.watch(homeRecordProvider);
                      return record.when(
                        data: (data) => data.isEmpty
                            ? Column(
                                children: [
                                  30.verticalSpace,
                                  const EmptyWidget(
                                    text: 'Nothing to see here',
                                  ),
                                ],
                              )
                            : Column(
                                children: data
                                    .map((e) => RecordCard(record: e))
                                    .toList(),
                              ),
                        error: (error, trace) {
                          error as DioException;
                          return ErrorScreen(
                            error: error,
                            reload: () => ref.invalidate(homeRecordProvider),
                          );
                        },
                        loading: () => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0; i <= 3; i++)
                                const HomeRecordShimmer(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  150.verticalSpace,
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
