import '../utils/utils.dart';

class LoadingButton extends StatelessWidget {
  final AppButton normal;
  final bool isLoading;
  const LoadingButton({
    super.key,
    required this.normal,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.r),
              ),
              textStyle: CustomTextStyle.text700_16,
              padding: [28, 12].pad,
              backgroundColor: AppColor.red60,
              minimumSize: Size(205.w, 48.h),
            ),
            child: CircularProgressIndicator.adaptive(
              backgroundColor: AppColor.white,
            ),
          )
        : normal;
  }
}

class AppButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        textStyle: CustomTextStyle.text700_16,
        padding: [28, 12].pad,
        backgroundColor: AppColor.red60,
        minimumSize: Size(205.w, 48.h),
      ),
      child: Text(text),
    ).animate().scale();
  }
}

class RoundIconButton extends StatelessWidget {
  final String icon;
  final Function() onTap;
  final double paddingLeft;
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.paddingLeft = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        paddingLeft.horizontalSpace,
        InkWell(
          borderRadius: BorderRadius.circular(100.r),
          onTap: onTap,
          child: Container(
            height: 40.r,
            width: 40.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.dark10,
            ),
            child: SvgPicture.asset(
              icon,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ],
    );
  }
}

class SvgButton extends StatelessWidget {
  final String icon;
  final Function() onTap;
  const SvgButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100.r),
      onTap: onTap,
      child: SvgPicture.asset(
        icon,
        fit: BoxFit.scaleDown,
      ),
    ).animate().scale();
  }
}
