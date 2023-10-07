part of 'controller.dart';

class CreateRecordView
    extends StatelessView<CreateRecordScreen, CreateRecordController> {
  const CreateRecordView(CreateRecordController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Create a record',
        centerTitle: false,
      ),
      body: Form(
        key: controller.key,
        child: ListView(
          padding: [16, 32, 16, 0].pad,
          children: [
            CustomTextInput(
              controller: controller.senderName,
              titleText: 'Senders name*',
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              textInputAction: TextInputAction.next,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter senders name';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.amount,
              titleText: 'Amount*',
              keyboardType: TextInputType.number,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              textInputAction: TextInputAction.next,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter an amount';
                } else if (double.tryParse(p0) == null) {
                  return 'Please, enter a valid amount';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.bankName,
              titleText: 'Bank name / cash',
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter bank name';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.accountNumber,
              titleText: 'Account number (recipient)',
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter an account number';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.accountName,
              titleText: 'Account name (recipient)',
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter an account name';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.details,
              titleText: 'Detail / Purpose*',
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter details of record';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.date,
              titleText: 'Transaction date',
              onTap: controller.selectDate,
              readOnly: true,
              suffixIcon: const SvgButton(
                icon: AppSvg.agenda,
              ),
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              textInputAction: TextInputAction.next,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, select a date';
                }
                return null;
              },
            ),
            32.verticalSpace,
            Text(
              'Evidence of payment (pdf or Jpeg file)',
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            32.verticalSpace,
            ValueListenableBuilder(
              valueListenable: controller.file,
              builder: (context, value, _) {
                return Container(
                  height: 140.h,
                  decoration: BoxDecoration(
                    color: AppColor.grey1,
                    borderRadius: BorderRadius.circular(8.r),
                    border: value == null
                        ? null
                        : Border.all(
                            color: AppColor.red60,
                          ),
                  ),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: value == null
                            ? SvgButton(
                                icon: AppSvg.upload,
                                onTap: controller.pickImage,
                              )
                            : Image.file(value).animate().scale(),
                      ),
                      if (value != null)
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RoundIconButton(
                              backgroundColor: AppColor.red60,
                              mainAxisAlignment: MainAxisAlignment.end,
                              icon: AppSvg.checked,
                              onTap: () => controller.file.value = null,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
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
            GroupedSelection<int>(
              initialIndex: 1,
              content: const ['Debit', 'Credit'],
              type: const [0, 1],
              onTap: <int>(position) {
                debugPrint('$position');
              },
            ),
            65.verticalSpace,
            Center(
              child: ValueListenableBuilder(
                valueListenable: controller.isLoading,
                builder: (context, state, _) {
                  return LoadingButton(
                    isLoading: state,
                    normal: AppButton(
                      text: 'Save',
                      onTap: controller.createRecord,
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
