import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recordam/widgets/notifications.dart';
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
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
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
          borderRadius: BorderRadius.circular(8),
        ),
        surfaceTintColor: AppColor.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            20.verticalSpacing,
            Text(
              'New',
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 18.spMin,
              ),
            ),
            10.verticalSpacing,
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColor.red60,
                radius: 20,
                child: SvgPicture.asset(
                  AppSvg.record,
                ),
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                showRecordTypeModal();
              },
              title: Text(
                'Add a Record',
                style: TextStyle(
                  color: AppColor.grey100,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.spMin,
                ),
              ),
            ),
            10.verticalSpacing,
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColor.red60,
                radius: 20,
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
                  fontSize: 16.spMin,
                ),
              ),
            ),
            38.verticalSpacing,
          ],
        ),
      ).animate().move(),
    ).whenComplete(() => controller.reverse());
  }

  void showRecordTypeModal({List<SharedMediaFile>? media}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        surfaceTintColor: AppColor.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            20.verticalSpacing,
            Text(
              'Select record type',
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 18.spMin,
              ),
            ),
            10.verticalSpacing,
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColor.red60,
                radius: 20,
                child: SvgPicture.asset(
                  AppSvg.record,
                ),
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                context.pushNamed(
                  CreateRecordScreen.name,
                  extra: media != null ? Create(media: media) : null,
                );
              },
              title: Text(
                'Create Transaction',
                style: TextStyle(
                  color: AppColor.grey100,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.spMin,
                ),
              ),
            ),
            10.verticalSpacing,
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColor.red60,
                radius: 20,
                child: SvgPicture.asset(
                  AppSvg.book,
                ),
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                context.pushNamed(
                  CreateListScreen.name,
                  extra: media != null ? Create(media: media) : null,
                );
              },
              title: Text(
                'Create List',
                style: TextStyle(
                  color: AppColor.grey100,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.spMin,
                ),
              ),
            ),
            38.verticalSpacing,
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
      backgroundColor: AppColor.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
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
            40.verticalSpacing,
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
          borderRadius: BorderRadius.circular(8),
        ),
        surfaceTintColor: AppColor.white,
        child: Padding(
          padding: [16, 21].pad,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Delete account",
                style: TextStyle(
                  fontSize: 16.spMin,
                  fontWeight: FontWeight.w700,
                ),
              ),
              25.verticalSpacing,
              Text(
                "This will delete your account permanently. You cannot undo this action.",
                style: TextStyle(
                  fontSize: 14.spMin,
                  fontWeight: FontWeight.w400,
                  color: AppColor.light100,
                ),
              ),
              40.verticalSpacing,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16.spMin,
                        fontWeight: FontWeight.w700,
                        color: AppColor.grey20,
                      ),
                    ),
                  ),
                  40.horizontalSpacing,
                  Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 16.spMin,
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
    var details = FutureProvider<RecordsDetails>((ref) async {
      return GetRequest.instance.getRecordsDetails();
    });

    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: AppColor.white,
      builder: (contex) => SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.5,
        child: SingleChildScrollView(
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
                      8.horizontalSpacing,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocalStorage.instance.getName(),
                            style: TextStyle(
                              fontSize: 16.spMin,
                              fontWeight: FontWeight.w700,
                              color: AppColor.grey100,
                            ),
                          ),
                          Text(
                            LocalStorage.instance.getEmail(),
                            style: TextStyle(
                              fontSize: 14.spMin,
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
              10.verticalSpacing,
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
                        height: 52,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppSvg.unconfirmed,
                            ),
                            16.horizontalSpacing,
                            Expanded(
                              child: Text(
                                "Unconfirmed records",
                                style: TextStyle(
                                  fontSize: 16.spMin,
                                  color: AppColor.grey100,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Consumer(builder: (context, ref, _) {
                              var count = ref.watch(details);
                              return Text(
                                count.when(
                                  data: (data) => '${data.unconfirmed}',
                                  error: (error, trace) => '...',
                                  loading: () => '...',
                                ),
                                style: TextStyle(
                                  fontSize: 14.spMin,
                                  color: AppColor.grey100,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    8.verticalSpacing,
                    InkWell(
                      onTap: () {
                        contex.pop();
                        context.pushNamed(PostedRecordsScreen.name);
                      },
                      child: SizedBox(
                        height: 52,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppSvg.posted,
                            ),
                            16.horizontalSpacing,
                            Expanded(
                              child: Text(
                                "Posted records",
                                style: TextStyle(
                                  fontSize: 16.spMin,
                                  color: AppColor.grey100,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Consumer(builder: (context, ref, _) {
                              var count = ref.watch(details);
                              return Text(
                                count.when(
                                  data: (data) => '${data.posted}',
                                  error: (error, trace) => '...',
                                  loading: () => '...',
                                ),
                                style: TextStyle(
                                  fontSize: 14.spMin,
                                  color: AppColor.grey100,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    8.verticalSpacing,
                    InkWell(
                      onTap: () {
                        contex.pop();
                        context.pushNamed(ChangePinScreen.name);
                      },
                      child: SizedBox(
                        height: 52,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppSvg.pin,
                            ),
                            16.horizontalSpacing,
                            Expanded(
                              child: Text(
                                "Change pin",
                                style: TextStyle(
                                  fontSize: 16.spMin,
                                  color: AppColor.grey100,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    8.verticalSpacing,
                    InkWell(
                      onTap: () {
                        contex.pop();
                        deleteAccount();
                      },
                      child: SizedBox(
                        height: 52,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppSvg.delete,
                            ),
                            16.horizontalSpacing,
                            Expanded(
                              child: Text(
                                "Delete account",
                                style: TextStyle(
                                  fontSize: 16.spMin,
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
              40.verticalSpacing,
            ],
          ),
        ),
      ).animate().shakeY(),
    );
  }

  void showNotificationModal() {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: AppColor.white,
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
                      fontSize: 16.spMin,
                      fontWeight: FontWeight.w700,
                      color: AppColor.grey100,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      PostRequest.instance
                          .markAllAsRead()
                          .then((value) =>
                              ShowFlushBar.showSuccess(message: value))
                          .catchError((error) {
                        listenError(error: error);
                      });
                      refreshController.requestRefresh();
                    },
                    child: Text(
                      "Mark all as read",
                      style: TextStyle(
                        fontSize: 12.spMin,
                        fontWeight: FontWeight.w700,
                        color: AppColor.red60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: AppColor.dark20,
              thickness: 1,
            ),
            Expanded(
              child: Notifications(
                refreshController: refreshController,
              ),
            ),
            40.verticalSpacing,
          ],
        ),
      ).animate().shakeY(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(shareIntentProvider, (previous, next) {
      showRecordTypeModal(media: next);
    });
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 128,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: CirclePath(),
                child: Container(
                  height: 100,
                  padding: [22, 0].pad,
                  color: AppColor.red60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            20.verticalSpacing,
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
                            20.verticalSpacing,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgButton(
                                  icon: AppSvg.search,
                                  onTap: showSearchModal,
                                ),
                                37.horizontalSpacing,
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
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                    radius: 28,
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
