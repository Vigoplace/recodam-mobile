part of 'controller.dart';

class RecordView extends StatelessView<RecordScreen, RecordController> {
  const RecordView(RecordController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Back",
        centerTitle: false,
      ),
      body: ListView(padding: [16, 51, 16, 0].pad, children: <Widget>[
        Center(
          child: SizedBox(
            child: Image.asset(AppImages.image),
          ),
        ),
        32.verticalSpace,
        CustomTextInput(
          titleText: "Amount",
          fillColor: AppColor.grey1,
          hintText: "20,000",
        ),
        32.verticalSpace,
        CustomTextInput(
          titleText: "Senders name",
          fillColor: AppColor.grey1,
          hintText: "Micheal Evans",
        ),
        32.verticalSpace,
        const CustomTextInput(
          titleText: "Bank details/Cash",
          hintText: "1234567890-FCMB",
        ),
        32.verticalSpace,
        CustomTextInput(
          titleText: "Transaction details/Purpose",
          fillColor: AppColor.grey1,
          hintText: "School donation",
        ),
        32.verticalSpace,
        CustomTextInput(
          titleText: "Add more details",
          fillColor: AppColor.grey1,
          hintText: "Money for maryland school donation",
        ),
        32.verticalSpace,
        const CustomTextInput(
          titleText: "Add to book",
          hintText: "Choose book",
          suffixIcon: Icon(Icons.arrow_drop_down_sharp),
        ),
        32.verticalSpace,
        Row(
          children: [
            Text(
              'Post',
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            32.horizontalSpace,
            AppButton(text: "Save", onTap: () {})
          ],
        ),
        32.verticalSpace,
      ]),
    );
  }
}
