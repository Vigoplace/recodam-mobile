part of 'controller.dart';

class RecordView extends StatelessView<RecordScreen, RecordController> {
  const RecordView(super.state, {super.key});

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
                            : switch (widget.info.record.file.endsWith('pdf')) {
                                true => Center(
                                    child: PdfView(
                                      controller: controller.pdfController,
                                    ),
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
          ValueListenableBuilder(
              valueListenable: controller.isPost,
              builder: (context, post, _) {
                return post
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          32.verticalSpace,
                          CustomTextInput(
                            titleText:
                                "${widget.info.record.isDatabase ? "Update" : "Add to"} book",
                            hintText: "Choose book",
                            suffixIcon: const SvgButton(
                              icon: AppSvg.chevronDown,
                            ),
                            readOnly: true,
                            controller: controller.book,
                            onTap: controller.chooseBook,
                          ),
                          30.verticalSpace,
                        ],
                      );
              }),
          ValueListenableBuilder(
            valueListenable: controller.user,
            builder: (context, user, _) {
              return user != null
                  ? Column(
                      children: [
                        8.verticalSpace,
                        Align(
                          alignment: Alignment.center,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Post this book to ${user.name}\'s ${controller.bookId == null ? 'Dashboard' : '${controller.book.text} book'}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        30.verticalSpace,
                      ],
                    )
                  : const SizedBox.shrink();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if ([DetailType.view].contains(widget.info.type))
                Align(
                  alignment: Alignment.centerLeft,
                  child: ValueListenableBuilder(
                      valueListenable: controller.isPost,
                      builder: (context, isPost, _) {
                        return TextButton(
                          onPressed: () {
                            if (isPost) {
                              controller.isPost.value = false;
                              controller.user.value = null;
                              controller.book.clear();
                            } else {
                              controller.onPublicBookSelection();
                            }
                          },
                          child: Text(
                            isPost ? 'Cancel' : 'Post',
                            style: TextStyle(
                              color: AppColor.red100,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      }),
                ),
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: controller.buttonState,
                builder: (context, state, _) {
                  return ValueListenableBuilder(
                    valueListenable: controller.isPost,
                    builder: (context, post, _) {
                      return post
                          ? LoadingButton(
                              isLoading: state.isLoading,
                              width: 100.w,
                              normal: AppButton(
                                width: 100.w,
                                text: "Update",
                                onTap: controller.createRecord,
                              ),
                            )
                          : LoadingButton(
                              isLoading: state.isLoading,
                              width: 100.w,
                              normal: AppButton(
                                width: 100.w,
                                enable: state.send,
                                text: widget.info.record.isDatabase
                                    ? "Update"
                                    : "Save",
                                onTap: controller.createRecord,
                              ),
                            );
                    },
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
