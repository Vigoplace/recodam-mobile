part of 'controller.dart';

class HomeView extends StatelessView<HomeScreen, HomeController> {
  const HomeView(HomeController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.white,
            centerTitle: false,
            // pinned: true,
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
                  itemBuilder: (context, index) => Container(
                    padding: [0, 0, 0, 1.5].pad,
                    decoration: BoxDecoration(
                      color: AppColor.red60,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    width: 220.w,
                    margin: [0, 0, 16, 0].pad,
                    child: Container(
                      padding: [16, 23].pad,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "School Donations",
                            style: CustomTextStyle.text700_14.withColor(
                              AppColor.grey100,
                            ),
                          ),
                          21.verticalSpace,
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppSvg.rect,
                              ),
                              16.horizontalSpace,
                              Text(
                                "N10,000",
                                style: CustomTextStyle.text400_14.withColor(
                                  AppColor.grey100,
                                ),
                              )
                            ],
                          ),
                          16.verticalSpace,
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppSvg.clock,
                              ),
                              16.horizontalSpace,
                              Text(
                                "2 days ago",
                                style: CustomTextStyle.text400_14.withColor(
                                  AppColor.grey100,
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppSvg.card,
                              ),
                              6.horizontalSpace,
                              Text(
                                "12",
                                style: CustomTextStyle.text400_12.withColor(
                                  AppColor.grey100,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
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
              for (int i = 0; i <= 10; i++)
                Container(
                  padding: [20, 22].pad,
                  margin: [16, 0, 16, 16].pad,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Micheal Evans",
                            style: CustomTextStyle.text700_14.withColor(
                              AppColor.grey100,
                            ),
                          ),
                          Text(
                            "N10,000",
                            style: CustomTextStyle.text700_14.withColor(
                              AppColor.grey100,
                            ),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      Text(
                        "First Bank of Nigeria",
                        style: CustomTextStyle.text700_11.withColor(
                          AppColor.grey100,
                        ),
                      ),
                      23.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Maryland school donation for kids.",
                            style: CustomTextStyle.text400_14.withColor(
                              AppColor.grey40,
                            ),
                          ),
                          RoundIconButton(
                            icon: AppSvg.moreVert,
                            onTap: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              //CARD
            ],
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 128.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: CirclePath(),
                child: Container(
                  height: 100.h,
                  padding: [22, 0].pad,
                  color: AppColor.red60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            20.verticalSpace,
                            Row(
                              children: [
                                SvgButton(
                                  icon: AppSvg.menu,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            20.verticalSpace,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgButton(
                                  icon: AppSvg.search,
                                  onTap: () {},
                                ),
                                37.horizontalSpace,
                                SvgButton(
                                  icon: AppSvg.bell,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, -1),
              child: CircleAvatar(
                radius: 28.h,
                backgroundColor: AppColor.red60,
                child: Icon(
                  Icons.add,
                  color: AppColor.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
