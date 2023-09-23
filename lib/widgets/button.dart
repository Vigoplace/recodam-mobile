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
              textStyle: TextStyle(
                color: AppColor.white,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
              padding: [28, 12].pad,
              backgroundColor: AppColor.red60,
              minimumSize: Size(205.w, 48.h),
            ),
            child: CircularProgressIndicator.adaptive(
              backgroundColor: AppColor.white,
              valueColor: AlwaysStoppedAnimation(AppColor.red30),
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
        textStyle: TextStyle(
          color: AppColor.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.sp,
        ),
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
  final Color? backgroundColor;
  final MainAxisAlignment mainAxisAlignment;
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.paddingLeft = 0,
    this.backgroundColor,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
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
              color: backgroundColor ?? AppColor.dark10,
            ),
            child: SvgPicture.asset(
              icon,
              fit: BoxFit.scaleDown,
            ),
          ).animate().scale(),
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

class GroupedSelection<T> extends StatefulWidget {
  final List<String> content;
  final List<T> type;
  final void Function<T>(T) onTap;
  final int initialIndex;

  const GroupedSelection({
    super.key,
    required this.content,
    required this.onTap,
    required this.type,
    this.initialIndex = 0,
  });

  @override
  State<GroupedSelection> createState() => _GroupedSelectionState();
}

class _GroupedSelectionState extends State<GroupedSelection> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 16.w,
        runSpacing: 24.h,
        children: widget.content
            .map((e) => InkWell(
                  borderRadius: BorderRadius.circular(100.r),
                  onTap: () {
                    index = widget.content.indexOf(e);
                    widget.onTap(widget.type[index]);
                    setState(() {});
                  },
                  child: Container(
                    height: 40.h,
                    width: 105.w,
                    decoration: BoxDecoration(
                      color: AppColor.grey1,
                      borderRadius: BorderRadius.circular(100.r),
                      border: widget.content.indexOf(e) == index
                          ? Border.all(
                              width: 1,
                              color: AppColor.red60,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        e,
                        style: TextStyle(
                          color: AppColor.grey100,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .scale(duration: const Duration(milliseconds: 800)),
                ))
            .toList());
  }
}
