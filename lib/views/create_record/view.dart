part of 'controller.dart';

class CreateRecordView
    extends StatelessView<CreateRecordScreen, CreateRecordController> {
  const CreateRecordView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Create a transaction record',
        centerTitle: false,
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: [16, 32, 16, 0].pad,
          cacheExtent: 500,
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
              prefix: InkWell(
                overlayColor: WidgetStateColor.transparent,
                onTap: controller.showCurrencyList,
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                ThousandsSeparatorInputFormatter(),
              ],
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              textInputAction: TextInputAction.next,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter an amount';
                } else if (double.tryParse(p0.amount) == null) {
                  return 'Please, enter a valid amount';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.bankName,
              titleText: 'Bank name',
              readOnly: true,
              prefix: const SvgButton(
                icon: AppSvg.chevronDown,
              ),
              onTap: controller.showBankList,
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.accountNumber,
              titleText: 'Account number (recipient)',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0!.isNotEmpty) {
                  if (double.tryParse(p0) == null) {
                    return 'Please, enter a valid account number';
                  }
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.accountName,
              titleText: 'Account name (recipient)',
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.details,
              titleText: 'Detail / Purpose*',
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter details';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.date,
              titleText: 'Transaction date*',
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
              'Evidence of payment (pdf or Jpeg file)*',
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            Text(
              '* max size is 3MB',
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 10.sp,
              ),
            ),
            10.verticalSpace,
            ValueListenableBuilder(
              valueListenable: controller.file,
              builder: (context, value, _) {
                return Container(
                  height: 300.h,
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
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: switch (value.path.endsWith('pdf')) {
                                  true => ViewPdf(
                                      path: value.path,
                                      
                                    ),
                                  _ => Image.file(value)
                                },
                              ),
                      ),
                      if (value != null)
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RoundIconButton(
                              backgroundColor: AppColor.red60,
                              mainAxisAlignment: MainAxisAlignment.end,
                              icon: AppSvg.remove,
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
              'Type of record*',
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            16.verticalSpace,
            GroupedSelection<RecordType>(
              initialIndex:
                  widget.create.bookId?.recordType ?? RecordType.debit,
              content: [
                if (widget.create.bookId?.recordType == null ||
                    widget.create.bookId?.recordType == RecordType.debit)
                  'Debit',
                if (widget.create.bookId?.recordType == null ||
                    widget.create.bookId?.recordType == RecordType.credit)
                  'Credit',
              ],
              type: [
                if (widget.create.bookId?.recordType == null ||
                    widget.create.bookId?.recordType == RecordType.debit)
                  RecordType.debit,
                if (widget.create.bookId?.recordType == null ||
                    widget.create.bookId?.recordType == RecordType.credit)
                  RecordType.credit,
              ],
              onTap: <RecordType>(position) => controller.recordType = position,
            ),
            65.verticalSpace,
            Center(
              child: AppButton(
                text: 'Save',
                onTap: controller.createRecord,
              ),
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
