part of 'controller.dart';

class ChangePinView
    extends StatelessView<ChangePinScreen, ChangePinController> {
  const ChangePinView(ChangePinController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Change pin',
        centerTitle: false,
      ),
      body: ListView(
        padding: [16, 50, 16, 0].pad,
        children: [
          const CustomTextInput(
            titleText: 'Old Pin',
          ),
          24.verticalSpace,
          const CustomTextInput(
            titleText: 'New Pin',
          ),
          24.verticalSpace,
          const CustomTextInput(
            titleText: 'Confirm New Pin',
          ),
          100.verticalSpace,
          Center(
            child: LoadingButton(
              isLoading: false,
              normal: AppButton(
                text: 'Update Password',
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
