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
                  style: CustomTextStyle.text700_16.withColor(
                    AppColor.grey100,
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
                          style: CustomTextStyle.text700_14.withColor(
                            AppColor.grey70,
                          ),
                        ),
                        Text(
                          'See all',
                          style: CustomTextStyle.text700_14.withColor(
                            AppColor.red60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  18.verticalSpace,
                  SizedBox(
                    height: 300.h,
                    child: ListView.builder(
                      itemCount: 10,
                      padding: EdgeInsets.only(left: 16.w),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => const BookCard(),
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
                          style: CustomTextStyle.text700_14.withColor(
                            AppColor.grey70,
                          ),
                        ),
                        Text(
                          'See all',
                          style: CustomTextStyle.text700_14.withColor(
                            AppColor.red60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  18.verticalSpace,
                  for (int i = 0; i <= 10; i++) const RecordCard(),
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
