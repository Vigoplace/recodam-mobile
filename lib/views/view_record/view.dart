part of 'controller.dart';

class RecordView extends StatelessView<RecordScreen, RecordController> {
  const RecordView(RecordController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: false,
        title: widget.record.isDatabase ? null : 'Confirm Record',
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
                      child: widget.record.isDatabase
                          ? ImageLoader(
                              image: widget.record.file,
                              boxFit: BoxFit.cover,
                            )
                          : Image.file(
                              File(widget.record.file),
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
                              image: widget.record.file,
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
            hintText: '${widget.record.symbol} ${widget.record.amount}',
            fillColor: AppColor.grey1,
            readOnly: true,
          ),
          32.verticalSpace,
          CustomTextInput(
            titleText: "Senders name",
            fillColor: AppColor.grey1,
            hintText: widget.record.senderName,
            readOnly: true,
          ),
          32.verticalSpace,
          CustomTextInput(
            titleText: "Transaction details/Purpose",
            fillColor: AppColor.grey1,
            hintText: widget.record.details,
            readOnly: true,
          ),
          32.verticalSpace,
          Builder(builder: (context) {
            String accountName = '';
            String bankName = '';
            String accountNumber = '';
            if (widget.record.accountName != null) {
              accountName = widget.record.accountName!;
            }
            if (widget.record.bankName != null) {
              bankName = widget.record.bankName!;
            }
            if (widget.record.accountNumber != null) {
              accountNumber = widget.record.accountNumber!;
            }
            return CustomTextInput(
              titleText: "Bank details",
              fillColor: AppColor.grey1,
              hintText: '$accountName $bankName $accountNumber',
              readOnly: true,
            );
          }),
          32.verticalSpace,
          CustomTextInput(
            titleText: "Add more details",
            hintText: "Money for maryland school donation",
            controller: controller.details,
          ),
          32.verticalSpace,
          CustomTextInput(
            titleText: "Add to book",
            hintText: "Choose book",
            suffixIcon: const SvgButton(
              icon: AppSvg.chevronDown,
            ),
            readOnly: true,
            controller: controller.book,
            onTap: controller.showBooks,
          ),
          65.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ValueListenableBuilder(
                valueListenable: controller.isLoading,
                builder: (context, state, _) {
                  return LoadingButton(
                    isLoading: state,
                    width: 100.w,
                    normal: AppButton(
                      width: 100.w,
                      text: widget.record.isDatabase ? "Update" : "Save",
                      onTap: controller.createRecord,
                    ),
                  );
                },
              ),
              if (!widget.record.isDatabase) ...[
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
          32.verticalSpace,
        ],
      ),
    );
  }
}
