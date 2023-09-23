part of 'controller.dart';

class SearchView extends StatelessView<SearchScreen, SearchController> {
  const SearchView(SearchController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Create a book',
        centerTitle: false,
      ),
      body: ListView(
        padding: [16, 32, 16, 0].pad,
        children: [
          const CustomTextInput(
            titleText: 'Book name*',
          ),
          32.verticalSpace,
          const CustomTextInput(
            titleText: 'Description',
          ),
          32.verticalSpace,
          const CustomTextInput(
            titleText: 'Opening balance',
          ),
          32.verticalSpace,
          Text(
            'Type of record',
            style: TextStyle(
              color: AppColor.grey100,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
          ),
          16.verticalSpace,
          GroupedSelection<int>(
            content: const ['Debit', 'Credit', 'Both', 'List'],
            type: const [0, 1, 2, 3],
            onTap: <int>(position) {
              debugPrint('$position');
            },
          ),
          52.verticalSpace,
          Text(
            'Manage access',
            style: TextStyle(
              color: AppColor.grey100,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
          ),
          16.verticalSpace,
          ValueListenableBuilder(
              valueListenable: controller.access,
              builder: (context, access, _) {
                return Column(
                  children: [
                    RadioListTile(
                      value: 'public',
                      activeColor: AppColor.red60,
                      groupValue: access,
                      onChanged: (value) {
                        controller.access.value = value!;
                      },
                      title: Text(
                        'Public',
                        style: TextStyle(
                          color: AppColor.grey100,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                        ),
                      ),
                      subtitle: Text(
                        'Anyone can post into this book',
                        style: TextStyle(
                          color: AppColor.grey100,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    RadioListTile(
                      value: 'private',
                      groupValue: access,
                      activeColor: AppColor.red60,
                      onChanged: (value) {
                        controller.access.value = value!;
                      },
                      title: Text(
                        'Private',
                        style: TextStyle(
                          color: AppColor.grey100,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                        ),
                      ),
                      subtitle: Text(
                        'Only the owner can post into this book',
                        style: TextStyle(
                          color: AppColor.grey100,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                );
              }),
          60.verticalSpace,
          Center(
            child: ValueListenableBuilder(
              valueListenable: controller.isLoading,
              builder: (context, state, _) {
                return LoadingButton(
                  isLoading: state,
                  normal: AppButton(
                    text: 'Save',
                    onTap: controller.login,
                  ),
                );
              },
            ),
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
