part of 'controller.dart';

class RecordView extends StatelessView<RecordScreen, RecordController> {
  const RecordView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: false,
        title: switch (widget.info.type) {
          DetailType.add => null,
          DetailType.create => 'Create record',
          DetailType.posted => 'Posted record',
          DetailType.unconfirmed => 'Unconfirmed Record',
          DetailType.view => null,
        },
      ),
      body: ListView(
        padding: [16, 22, 16, 0].pad,
        children: <Widget>[
          Center(
            child: Container(
              height: 242.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColor.grey,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: (widget.info.type == DetailType.view ||
                                widget.info.type == DetailType.unconfirmed ||
                                widget.info.type == DetailType.posted)
                            ? ImageLoader(
                                image: widget.info.record.file,
                                boxFit: BoxFit.cover,
                              )
                            : switch (widget.info.record.file.endsWith('pdf')) {
                                true => Center(
                                    child: Builder(builder: (context) {
                                      return ViewPdf(
                                        path: widget.info.record.file,
                                      );
                                    }),
                                  ),
                                _ => Image.file(File(widget.info.record.file))
                              }),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: [0, 0, 10, 10].pad,
                      child: SvgButton(
                        icon: AppSvg.expand,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewImage(
                              image: widget.info.record.file,
                              appBarText: 'Payment proof',
                              detailType: widget.info.type,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          32.verticalSpace,
          CustomTextInput(
            titleText: "Amount",
            hintStyle: TextStyle(
              fontFamily: 'Roboto',
              color: AppColor.grey40,
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
            ),
            hintText:
                '${widget.info.record.symbol} ${widget.info.record.amount}',
            fillColor: AppColor.grey1,
            readOnly: true,
          ),
          32.verticalSpace,
          CustomTextInput(
            titleText: "Senders name",
            fillColor: AppColor.grey1,
            hintText: widget.info.record.senderName,
            readOnly: true,
          ),
          32.verticalSpace,
          CustomTextInput(
            titleText: "Transaction details/Purpose",
            fillColor: AppColor.grey1,
            hintText: widget.info.record.details,
            readOnly: true,
          ),
          Builder(
            builder: (context) {
              String accountName = '';
              String bankName = '';
              String accountNumber = '';
              if (widget.info.record.accountName != null) {
                accountName = widget.info.record.accountName!;
              }
              if (widget.info.record.bankName != null) {
                bankName = widget.info.record.bankName!;
              }
              if (widget.info.record.accountNumber != null) {
                accountNumber = widget.info.record.accountNumber!;
              }
              return ((accountNumber + bankName + accountName).isEmpty)
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        32.verticalSpace,
                        Text(
                          'Bank details',
                          style: TextStyle(
                            color: AppColor.grey100,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                        ),
                        8.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.dark20,
                              ),
                              color: AppColor.grey1,
                              borderRadius: BorderRadius.circular(100.r)),
                          alignment: Alignment.centerLeft,
                          padding: [15, 18].pad,
                          child: Text(
                            '$accountName $bankName $accountNumber',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          ),
                        )
                      ],
                    );
            },
          ),
          if ([DetailType.view].contains(widget.info.type)) ...[
            32.verticalSpace,
            CustomTextInput(
              titleText: "Add more details",
              hintText: "Money for maryland school donation",
              controller: controller.details,
            ),
          ],
          32.verticalSpace,
          if (![DetailType.posted].contains(widget.info.type)) ...[
            ValueListenableBuilder(
              valueListenable: controller.user,
              builder: (context, user, _) {
                return user != null
                    ? Align(
                        alignment: Alignment.center,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                10.horizontalSpace,
                                Expanded(
                                  child: Text(
                                    'Post this record to ${user.name}\'s ${controller.bookId == null ? 'Dashboard' : '${controller.book.text} book'}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                SvgButton(
                                  icon: AppSvg.remove,
                                  onTap: () => controller.user.value = null,
                                ),
                                10.horizontalSpace,
                              ],
                            ),
                          ),
                        ),
                      )
                    : CustomTextInput(
                        titleText: switch (widget.info.type) {
                          DetailType.add => 'Update location',
                          DetailType.create => 'Select location',
                          DetailType.posted => 'Update location',
                          DetailType.unconfirmed => 'Update location',
                          DetailType.view => 'Update location',
                        },
                        suffixIcon: const SvgButton(
                          icon: AppSvg.chevronDown,
                        ),
                        readOnly: true,
                        controller: controller.book,
                        onTap: controller.chooseBook,
                      );
              },
            ),
            30.verticalSpace,
            Align(
              alignment: Alignment.centerRight,
              child: ValueListenableBuilder(
                valueListenable: controller.buttonState,
                builder: (context, state, _) {
                  return LoadingButton(
                    isLoading: state.isLoading,
                    width: 100.w,
                    normal: AppButton(
                      width: 100.w,
                      enable: state.send,
                      text: switch (widget.info.type) {
                        DetailType.add => 'Add to book',
                        DetailType.create => 'Post',
                        DetailType.posted => 'Update',
                        DetailType.unconfirmed => 'Confirm',
                        DetailType.view => 'Update',
                      },
                      onTap: controller.createRecord,
                    ),
                  );
                },
              ),
            ),
          ],
          if ([DetailType.posted].contains(widget.info.type)) ...[
            16.horizontalSpace,
            Text(
              'Delete',
              style: TextStyle(
                color: AppColor.red100,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
            ),
          ],
          50.verticalSpace,
        ],
      ),
    );
  }
}
