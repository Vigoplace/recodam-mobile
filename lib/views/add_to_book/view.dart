part of 'controller.dart';

class AddToBookView
    extends StatelessView<AddToBookScreen, AddToBookController> {
  const AddToBookView(AddToBookController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: CustomAppbar(
        title: '${widget.bookInfo.title.name.capitalize()} Book',
        centerTitle: false,
      ),
      body: Column(
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
                                "Richard Okafor",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              12.verticalSpace,
                              Text(
                                "0801234568",
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
                )
              ],
            ),
          ),
          Expanded(
            child: Books(
              pagination: controller.pagination,
              searchWord: controller.search,
              mini: true,
              onTap: controller.showConfirmation,
            ),
          ),
        ],
      ),
    );
  }
}
