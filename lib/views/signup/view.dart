part of 'controller.dart';

class SignupView extends StatelessView<SignupScreen, SignupController> {
  const SignupView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: Form(
        key: controller.key,
        child: ListView(
          padding: [16, 16, 16, 0].pad,
          cacheExtent: 500,
          children: [
            Text(
              'Create Account',
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.name,
              titleText: 'Full Name*',
              hintText: 'Individual or organization',
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              textInputAction: TextInputAction.next,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter your full name';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.email,
              titleText: 'Email',
              hintText: 'example@gmail.com',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (String? value) {
                if ((value == null || value.isEmpty) ||
                    !RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                        .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            32.verticalSpace,
            CustomTextInput(
              controller: controller.phone,
              titleText: 'Phone number*',
              hintText: '000-000-000',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              suffixIcon: InkWell(
                overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent,
                ),
                onTap: controller.showCountryList,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(AppSvg.chevronDown),
                    ValueListenableBuilder(
                      valueListenable: controller.country,
                      builder: (context, country, _) {
                        return Padding(
                          padding: const [0, 0, 15, 0].pad,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: SvgPicture.network(
                              country.flag,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              autovalidateMode: controller.submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please, enter your mobile number';
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            32.verticalSpace,
            ValueListenableBuilder(
              valueListenable: controller.showPin,
              builder: (context, state, _) {
                return CustomTextInput(
                  keyboardType: TextInputType.number,
                  controller: controller.pin,
                  titleText: 'Create pin*',
                  hintText: '123456',
                  obscureText: state,
                  suffixIcon: SvgButton(
                    icon: state ? AppSvg.eye : AppSvg.eyeOpen,
                    onTap: () => controller.showPin.value = !state,
                  ),
                  textInputAction: TextInputAction.next,
                  autovalidateMode: controller.submitted
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a pin';
                    } else if (value.length != 6) {
                      return 'Pin length must be 6 characters';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                );
              },
            ),
            32.verticalSpace,
            ValueListenableBuilder(
              valueListenable: controller.showConfirmPin,
              builder: (context, state, _) {
                return CustomTextInput(
                  controller: controller.confirm,
                  titleText: 'Confirm pin*',
                  hintText: '123456',
                  keyboardType: TextInputType.number,
                  obscureText: state,
                  suffixIcon: SvgButton(
                    icon: state ? AppSvg.eye : AppSvg.eyeOpen,
                    onTap: () => controller.showConfirmPin.value = !state,
                  ),
                  autovalidateMode: controller.submitted
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your pin';
                    } else if (value.length != 6) {
                      return 'Pin length must be 6 characters';
                    } else if (controller.pin.text != controller.confirm.text) {
                      return 'Pin mismatch';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                );
              },
            ),
            32.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder(
                  valueListenable: controller.acceptedTerms,
                  builder: (context, state, _) {
                    return SvgButton(
                      icon: state ? AppSvg.checked : AppSvg.checkmark,
                      onTap: () => controller.acceptedTerms.value = !state,
                    );
                  },
                ),
                8.horizontalSpace,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'By tapping create an account and using',
                          style: TextStyle(
                            color: AppColor.grey100,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                        TextSpan(
                          text: ' Recodam ',
                          style: TextStyle(
                            color: AppColor.grey100,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                        TextSpan(
                          text: 'you agree to our',
                          style: TextStyle(
                            color: AppColor.grey100,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                        TextSpan(
                          text: ' Terms ',
                          style: TextStyle(
                            color: AppColor.grey100,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                        TextSpan(
                          text: 'and',
                          style: TextStyle(
                            color: AppColor.grey100,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                        TextSpan(
                          text: ' Privacy policy ',
                          style: TextStyle(
                            color: AppColor.grey100,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            43.verticalSpace,
            ValueListenableBuilder(
              valueListenable: controller.isLoading,
              builder: (context, state, _) {
                return Center(
                  child: LoadingButton(
                    isLoading: state,
                    normal: AppButton(
                      text: 'CREATE ACCOUNT',
                      onTap: controller.create,
                    ),
                  ),
                );
              },
            ),
            40.verticalSpace,
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Have an account ?',
                      style: TextStyle(
                        color: AppColor.grey100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    ),
                    TextSpan(
                      text: ' Sign in',
                      style: TextStyle(
                        color: AppColor.red60,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            context.pushReplacementNamed(LoginScreen.name),
                    ),
                  ],
                ),
              ),
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
