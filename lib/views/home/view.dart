part of 'controller.dart';

class HomeView extends StatelessView<HomeScreen, HomeController> {
  const HomeView(HomeController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                title: Text(
                  'Welcome Jenny',
                  style: TextStyle(
                    color: AppColor.grey100,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                actions: [
                  Image.asset(AppImages.image),
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
                        Text(
                          'See all',
                          style: TextStyle(
                            color: AppColor.red60,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  18.verticalSpace,
                  SizedBox(
                    height: 300.h,
                    child: Consumer(
                      builder: (context, ref, _) {
                        var books = ref.watch(homeBookProvider);
                        return books.when(
                          data: (data) => ListView.builder(
                            itemCount: 10,
                            padding: EdgeInsets.only(left: 16.w),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => const BookCard(),
                          ),
                          error: (error, trace) => ErrorScreen(
                            error: error,
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
                        Text(
                          'See all',
                          style: TextStyle(
                            color: AppColor.red60,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
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
                        data: (data) => Column(
                          children: [
                            for (int i = 0; i <= 10; i++) const RecordCard(),
                          ],
                        ),
                        error: (error, trace) => ErrorScreen(
                          error: error,
                          reload: () => ref.invalidate(homeRecordProvider),
                        ),
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
