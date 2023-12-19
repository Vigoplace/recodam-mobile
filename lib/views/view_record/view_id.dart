part of 'controller.dart';

class ViewRecordById extends ConsumerStatefulWidget {
  final int recordId;
  const ViewRecordById({
    super.key,
    required this.recordId,
  });

  @override
  ConsumerState<ViewRecordById> createState() => _ViewRecordByIdState();
}

class _ViewRecordByIdState extends ConsumerState<ViewRecordById> {
  late FutureProvider<Record> getRecordProvider;
  @override
  void initState() {
    super.initState();
    getRecordProvider = FutureProvider(
      (ref) => GetRequest.instance.getRecord(id: widget.recordId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final record = ref.watch(getRecordProvider);
    return Scaffold(
      appBar: const CustomAppbar(
        centerTitle: true,
        title: 'View Record',
      ),
      body: record.when(
        data: (data) => ListView(
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
                          child: ImageLoader(
                            image: data.file,
                            boxFit: BoxFit.cover,
                          )),
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
                                image: data.file,
                                appBarText: 'Payment proof',
                                detailType: DetailType.view,
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
              hintText: '${data.symbol} ${data.amount}',
              fillColor: AppColor.grey1,
              readOnly: true,
            ),
            32.verticalSpace,
            CustomTextInput(
              titleText: "Senders name",
              fillColor: AppColor.grey1,
              hintText: data.senderName,
              readOnly: true,
            ),
            32.verticalSpace,
            CustomTextInput(
              titleText: "Transaction details/Purpose",
              fillColor: AppColor.grey1,
              hintText: data.details,
              readOnly: true,
            ),
            Builder(
              builder: (context) {
                String accountName = '';
                String bankName = '';
                String accountNumber = '';
                if (data.accountName != null) {
                  accountName = data.accountName!;
                }
                if (data.bankName != null) {
                  bankName = data.bankName!;
                }
                if (data.accountNumber != null) {
                  accountNumber = data.accountNumber!;
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
            50.verticalSpace,
          ],
        ),
        error: (error, trace) => ErrorScreen(
          error: error,
          reload: () => ref.invalidate(getRecordProvider),
          trace: trace,
        ),
        loading: () => const CustomLoader(),
      ),
    );
  }
}
