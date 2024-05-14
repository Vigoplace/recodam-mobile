part of 'controller.dart';

class ChangePinView
    extends StatelessView<ChangePinScreen, ChangePinController> {
  const ChangePinView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Change pin',
        centerTitle: false,
      ),
      body: Form(
        key: controller.key,
        child: ListView(
          padding: [16, 50, 16, 0].pad,
          children: [
            CustomTextInput(
              controller: controller.oldPin,
              titleText: 'Old Pin',
              hintText: '123456',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter your pin';
                } else if (int.tryParse(p0) == null) {
                  return 'Pin must be numeric';
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            24.verticalSpace,
            CustomTextInput(
              controller: controller.newPin,
              titleText: 'New Pin',
              hintText: '123456',
              maxLength: 6,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter your pin';
                } else if (int.tryParse(p0) == null) {
                  return 'Pin must be numeric';
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            24.verticalSpace,
            CustomTextInput(
              controller: controller.confirmPin,
              titleText: 'Confirm New Pin',
              hintText: '123456',
              keyboardType: TextInputType.number,
              maxLength: 6,
              textInputAction: TextInputAction.done,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter your pin';
                } else if (int.tryParse(p0) == null) {
                  return 'Pin must be numeric';
                } else if (p0 != controller.newPin.text) {
                  return 'Pin mismatch';
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            100.verticalSpace,
            Center(
              child: ValueListenableBuilder(
                valueListenable: controller.isLoading,
                builder: (context, loading, _) {
                  return LoadingButton(
                    isLoading: loading,
                    normal: AppButton(
                      text: 'Update Password',
                      onTap: controller.update,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
