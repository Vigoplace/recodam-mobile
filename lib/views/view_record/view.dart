part of 'controller.dart';

class RecordView extends StatelessView<RecordScreen, RecordController> {
  const RecordView(RecordController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: false,
        title: widget.info.record.isDatabase ? null : 'Confirm Record',
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
                      child: widget.info.record.isDatabase
                          ? ImageLoader(
                              image: widget.info.record.file,
                              boxFit: BoxFit.cover,
                            )
                          : widget.info.record.file.endsWith('pdf')
                              ? Image.asset(AppImages.pdf)
                              : Image.file(
                                  File(widget.info.record.file),
                                  fit: BoxFit.cover,
                                ),
                    ),
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
          32.verticalSpace,
          Builder(builder: (context) {
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
            return CustomTextInput(
              titleText: "Bank details",
              fillColor: AppColor.grey1,
              hintText: '$accountName $bankName $accountNumber',
              readOnly: true,
            );
          }),
          if ([DetailType.view].contains(widget.info.type)) ...[
            32.verticalSpace,
            CustomTextInput(
              titleText: "Add more details",
              hintText: "Money for maryland school donation",
              controller: controller.details,
            )
          ],
          32.verticalSpace,
          CustomTextInput(
            titleText: "Add to book",
            hintText: "Choose book",
            suffixIcon: const SvgButton(
              icon: AppSvg.chevronDown,
            ),
            readOnly: true,
            controller: controller.book,
            onTap: controller.chooseBook,
          ),
          65.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if ([DetailType.view].contains(widget.info.type))
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Post',
                      style: TextStyle(
                        color: AppColor.red100,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: controller.buttonState,
                builder: (context, state, _) {
                  return LoadingButton(
                    isLoading: state.isLoading,
                    width: 100.w,
                    normal: AppButton(
                      width: 100.w,
                      enable: state.send,
                      text: widget.info.record.isDatabase ? "Update" : "Save",
                      onTap: controller.createRecord,
                    ),
                  );
                },
              ),
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
              ]
            ],
          ),
          50.verticalSpace,
        ],
      ),
    );
  }
}
