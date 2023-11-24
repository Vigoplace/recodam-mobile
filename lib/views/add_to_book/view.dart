part of 'controller.dart';

class AddToBookView
    extends StatelessView<AddToBookScreen, AddToBookController> {
  const AddToBookView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    var user = controller.ref.watch(controller.info);
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: CustomAppbar(
        title: '${widget.bookInfo.title.name.capitalize()} Book',
        centerTitle: false,
      ),
      body: user.when(
        data: (data) => Column(
          children: [
            Container(
              color: AppColor.white,
              padding: [16, 20].pad,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      10.verticalSpace,
                      Text(
                        'Owner\'s Infromation',
                        style: TextStyle(
                          color: AppColor.grey40,
                        ),
                      ),
                      12.verticalSpace,
                      Container(
                        padding: [16, 16].pad,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          color: AppColor.grey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                12.verticalSpace,
                                Text(
                                  data.phone,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.grey40,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              AppImages.image,
                            ),
                          ],
                        ),
                      ),
                      20.verticalSpace,
                    ],
                  ),
                  CustomTextInput(
                    hintText: 'Search',
                    fillColor: AppColor.grey,
                    controller: controller.search,
                    prefix: const SvgButton(
                      icon: AppSvg.blackSearch,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  20.verticalSpace,
                  InkWell(
                    overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent,
                    ),
                    onTap: () => controller.showConfirmation(null),
                    child: Container(
                      padding: [16, 16].pad,
                      margin: [16].pad,
                      decoration: ShapeDecoration(
                        color: AppColor.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.dashboard,
                          ).animate().scale(),
                          20.horizontalSpace,
                          Text(
                            'To dashboard',
                            style: TextStyle(
                              color: AppColor.grey100,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Books(
                      pagination: controller.pagination,
                      searchWord: controller.search,
                      mini: true,
                      id: data.id,
                      onTap: controller.showConfirmation,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        error: (error, trace) {
          return ErrorScreen(
            error: error,
            trace: trace,
            reload: () => controller.ref.invalidate(controller.info),
          );
        },
        loading: () => const CustomLoader(),
      ),
    );
  }
}
