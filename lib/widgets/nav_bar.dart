import 'package:grouped_list/grouped_list.dart';

import '../utils/utils.dart';

class CustomBottomNavbar extends ConsumerStatefulWidget {
  const CustomBottomNavbar({
    super.key,
  });

  @override
  ConsumerState<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends ConsumerState<CustomBottomNavbar>
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
              'New',
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
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
                'Add a Record',
                style: TextStyle(
                  color: AppColor.grey100,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
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
                'Create a Book',
                style: TextStyle(
                  color: AppColor.grey100,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
              ),
            ),
            38.verticalSpace,
          ],
        ),
      ).animate().move(),
    ).whenComplete(() => controller.reverse());
  }

  void showSearchModal() {
    TextEditingController search = TextEditingController();
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
              child: TextField(
                controller: search,
                cursorColor: AppColor.grey100,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search here',
                  suffixIcon: SvgButton(
                    icon: AppSvg.searchBlack,
                  ),
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
                child: SearchModalContent(
                  searchController: search,
                ),
              ),
            ),
            40.verticalSpace,
          ],
        ),
      ).animate().shakeY(),
    );
  }

  void deleteAccount() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: [20, 0, 20, 0].pad,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: [16, 21].pad,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Delete account",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              25.verticalSpace,
              Text(
                "This will delete your account permanently. You cannot undo this action.",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.light100,
                ),
              ),
              40.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.grey20,
                      ),
                    ),
                  ),
                  40.horizontalSpace,
                  Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.red60,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMenuModal() {
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
      builder: (contex) => SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.5,
        child: Column(
          children: [
            Padding(
              padding: [16].pad,
              child: InkWell(
                onTap: () {
                  contex.pop();
                  context.pushNamed(ProfileScreen.name);
                },
                child: Row(
                  children: [
                    Consumer(
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
                    8.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocalStorage.instance.getName(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColor.grey100,
                          ),
                        ),
                        Text(
                          LocalStorage.instance.getEmail(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColor.grey40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: AppColor.dark20,
              thickness: 1,
            ),
            10.verticalSpace,
            Padding(
              padding: [16, 0].pad,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      contex.pop();
                      context.pushNamed(UnConfirmedRecordsScreen.name);
                    },
                    child: SizedBox(
                      height: 52.h,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.unconfirmed,
                          ),
                          16.horizontalSpace,
                          Expanded(
                            child: Text(
                              "Unconfirmed records",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColor.grey100,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "10",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColor.grey100,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  InkWell(
                    onTap: () {
                      contex.pop();
                      context.pushNamed(PostedRecordsScreen.name);
                    },
                    child: SizedBox(
                      height: 52.h,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.posted,
                          ),
                          16.horizontalSpace,
                          Expanded(
                            child: Text(
                              "Posted records",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColor.grey100,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "10",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColor.grey100,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  InkWell(
                    onTap: () {
                      contex.pop();
                      context.pushNamed(ChangePinScreen.name);
                    },
                    child: SizedBox(
                      height: 52.h,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.pin,
                          ),
                          16.horizontalSpace,
                          Expanded(
                            child: Text(
                              "Change pin",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColor.grey100,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  InkWell(
                    onTap: () {
                      contex.pop();
                      deleteAccount();
                    },
                    child: SizedBox(
                      height: 52.h,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.delete,
                          ),
                          16.horizontalSpace,
                          Expanded(
                            child: Text(
                              "Delete account",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColor.grey100,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            40.verticalSpace,
          ],
        ),
      ).animate().shakeY(),
    );
  }

  void showNotificationModal() {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.grey100,
                    ),
                  ),
                  Text(
                    "Mark all as read",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.red60,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: AppColor.dark20,
              thickness: 1,
            ),
            Expanded(
              child: GroupedListView<int, DateTime>(
                padding: [16, 10, 16, 0].pad,
                elements: List.generate(20, (index) => index += 1),
                groupHeaderBuilder: (element) => Padding(
                  padding: [0, 0, 0, 16].pad,
                  child: Text(
                    "New",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.grey100,
                    ),
                  ),
                ),
                itemBuilder: (context, element) => SizedBox(
                  height: 80.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AppImages.image).animate().scale(),
                      10.horizontalSpace,
                      Expanded(
                        child: Text(
                          "Rachel added a new record to shopping list.",
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColor.grey100,
                          ),
                        ),
                      ),
                      30.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Just now",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColor.red100,
                            ),
                          ),
                          8.verticalSpace,
                          CircleAvatar(
                            radius: 4.r,
                            backgroundColor: AppColor.red60,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                groupBy: (groupBy) => DateTime.now(),
              ),
            ),
            40.verticalSpace,
          ],
        ),
      ).animate().shakeY(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(shareIntentProvider, (previous, next) {
      context.pushNamed(
        CreateRecordScreen.name,
        extra: Create(media: next),
      );
    });
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
                                  onTap: showMenuModal,
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
                                  onTap: showNotificationModal,
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
                borderRadius: BorderRadius.circular(100.r),
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
