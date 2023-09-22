import '../utils/utils.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({
    super.key,
  });

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 100),
      upperBound: 0.1,
      lowerBound: 0,
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          showModal();
        }
      });
  }

  void showModal() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            38.verticalSpace,
            Text(
              'Create new',
              style: CustomTextStyle.text700_18,
            ),
            30.verticalSpace,
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColor.red60,
                radius: 20.w,
                child: SvgPicture.asset(
                  AppSvg.record,
                ),
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                context.pushNamed(CreateRecordScreen.name);
              },
              title: Text(
                'Record',
                style: CustomTextStyle.text400_16,
              ),
            ),
            32.verticalSpace,
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColor.red60,
                radius: 20.w,
                child: SvgPicture.asset(
                  AppSvg.book,
                ),
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                context.pushNamed(CreateBookScreen.name);
              },
              title: Text(
                'Book',
                style: CustomTextStyle.text400_16,
              ),
            ),
            38.verticalSpace,
          ],
        ),
      ).animate().move(),
    ).whenComplete(() => controller.reverse());
  }

  void showSearchModal() {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: Column(
          children: [
            Padding(
              padding: [16].pad,
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            Divider(
              color: AppColor.dark20,
              thickness: 1,
            ),
            Expanded(
              child: Container(
                color: AppColor.grey1,
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        isScrollable: true,
                        labelStyle: CustomTextStyle.text700_16,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: AppColor.red60,
                        unselectedLabelStyle: CustomTextStyle.text400_16,
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
                        // height: MediaQuery.sizeOf(context).height * 0.6,
                        child: TabBarView(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  24.verticalSpace,
                                  Padding(
                                    padding: [16].pad,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Recently Visited',
                                        style: CustomTextStyle.text700_14
                                            .withColor(
                                          AppColor.light100,
                                        ),
                                      ),
                                    ),
                                  ),
                                  18.verticalSpace,
                                  for (int i = 0; i <= 10; i++)
                                    Container(
                                      padding: [16, 16].pad,
                                      margin: [16, 0, 16, 16].pad,
                                      decoration: ShapeDecoration(
                                        color: AppColor.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppSvg.card,
                                          ),
                                          16.horizontalSpace,
                                          Text(
                                            'Birthday',
                                            style: CustomTextStyle.text700_16
                                                .withColor(
                                              AppColor.grey100,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '12',
                                            style: CustomTextStyle.text400_14
                                                .withColor(
                                              AppColor.grey40,
                                            ),
                                          )
                                        ],
                                      ),
                                    ).animate().scale(),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  24.verticalSpace,
                                  Padding(
                                    padding: [16].pad,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Recently Visited',
                                        style: CustomTextStyle.text700_14
                                            .withColor(
                                          AppColor.light100,
                                        ),
                                      ),
                                    ),
                                  ),
                                  18.verticalSpace,
                                  for (int i = 0; i <= 10; i++)
                                    Container(
                                      padding: [16, 16].pad,
                                      margin: [16, 0, 16, 16].pad,
                                      decoration: ShapeDecoration(
                                        color: AppColor.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Lux beauty store',
                                                style: CustomTextStyle
                                                    .text700_14
                                                    .withColor(
                                                  AppColor.grey100,
                                                ),
                                              ),
                                              10.verticalSpace,
                                              Text(
                                                'Shopping bill',
                                                style: CustomTextStyle
                                                    .text400_14
                                                    .withColor(
                                                  AppColor.grey100,
                                                ),
                                              ),
                                              10.verticalSpace,
                                              Text(
                                                'Yesterday 7:59pm',
                                                style: CustomTextStyle
                                                    .text700_11
                                                    .withColor(
                                                  AppColor.grey100,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          SvgPicture.asset(
                                            AppSvg.card,
                                          ),
                                        ],
                                      ),
                                    ).animate().scale(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            40.verticalSpace,
          ],
        ),
      ).animate().scale(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
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
                                  onTap: showSearchModal,
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
              child: InkWell(
                onTap: () {
                  if (controller.value == 0.0) {
                    controller.forward();
                  } else {
                    controller.reverse();
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CircleAvatar(
                    radius: 28.h,
                    backgroundColor: AppColor.red60,
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 100),
                      turns: controller.value,
                      child: Icon(
                        Icons.add,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
