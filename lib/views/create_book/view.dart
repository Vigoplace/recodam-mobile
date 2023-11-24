part of 'controller.dart';

class CreateBookView
    extends StatelessView<CreateBookScreen, CreateBookController> {
  const CreateBookView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Create a book',
        centerTitle: false,
      ),
      body: Form(
        key: controller.key,
        child: ListView(
          padding: [16, 32, 16, 0].pad,
          children: [
            CustomTextInput(
              titleText: 'Book name*',
              controller: controller.bookName,
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter a book name';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              titleText: 'Description',
              controller: controller.description,
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter a book description';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              titleText: 'Opening balance',
              textInputAction: TextInputAction.next,
              controller: controller.balance,
              keyboardType: TextInputType.number,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              prefix: InkWell(
                onTap: controller.showCurrencyList,
                overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    10.horizontalSpace,
                    ValueListenableBuilder(
                      valueListenable: controller.currency,
                      builder: (context, value, _) {
                        return Text(
                          value.symbol,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        );
                      },
                    ),
                    3.horizontalSpace,
                    const SvgButton(
                      icon: AppSvg.chevronDown,
                    ),
                  ],
                ),
              ),
              validator: (p0) {
                if (p0 == null || p0.isEmpty || double.tryParse(p0) == null) {
                  return 'Please, enter a valid opening balance';
                }
                return null;
              },
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
            GroupedSelection<RecordType>(
              initialIndex: controller.recordType,
              content: const [
                'Debit',
                'Credit',
                'Both',
                'List',
              ],
              type: const [
                RecordType.debit,
                RecordType.credit,
                RecordType.both,
                RecordType.list,
              ],
              onTap: (position) => controller.recordType = position,
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
                      RadioListTile<ManageAcess>(
                        value: ManageAcess.public,
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
                      RadioListTile<ManageAcess>(
                        value: ManageAcess.private,
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
                      onTap: controller.createBook,
                    ),
                  );
                },
              ),
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
