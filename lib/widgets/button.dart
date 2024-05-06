import 'dart:async';

import '../utils/utils.dart';

class LoadingButton extends StatelessWidget {
  final AppButton normal;
  final Widget? loading;
  final bool isLoading;
  final double? width;

  const LoadingButton({
    super.key,
    required this.normal,
    this.width,
    required this.isLoading,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loading ??
            Container(
              height: 50.h,
              width: width ?? 205.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: AppColor.red60,
              ),
              alignment: Alignment.center,
              child: CircularProgressIndicator.adaptive(
                backgroundColor: AppColor.white,
                valueColor: AlwaysStoppedAnimation(AppColor.red30),
              ),
            )
        : normal;
  }
}

class AppButton extends StatefulWidget {
  final String text;
  final Function() onTap;
  final double? width;
  final Widget? icon;
  final bool enable;
  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.enable = true,
    this.icon,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  late Timer _timer;
  late bool enable;

  @override
  void initState() {
    super.initState();
    enable = widget.enable;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      enable = widget.enable;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enable ? widget.onTap : null,
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
        minimumSize: Size(widget.width ?? 205.w, 48.h),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) ...[
            widget.icon!,
            8.horizontalSpace,
          ],
          Text(
            widget.text,
            style: TextStyle(
              color: AppColor.white,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final String icon;
  final Function()? onTap;
  final double paddingLeft;
  final Color? backgroundColor;
  final MainAxisAlignment mainAxisAlignment;
  const RoundIconButton({
    super.key,
    required this.icon,
    this.onTap,
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
  final Function()? onTap;
  const SvgButton({
    super.key,
    required this.icon,
    this.onTap,
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
  final void Function(dynamic) onTap;
  final T initialIndex;

  const GroupedSelection({
    super.key,
    required this.content,
    required this.onTap,
    required this.type,
    required this.initialIndex,
  });

  @override
  State<GroupedSelection> createState() => _GroupedSelectionState();
}

class _GroupedSelectionState<T> extends State<GroupedSelection> {
  late T currentChoice;

  @override
  void initState() {
    super.initState();
    currentChoice = widget.initialIndex;
    setState(() {});
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
                    currentChoice =
                        widget.type.elementAt(widget.content.indexOf(e));
                    widget.onTap(currentChoice);
                    setState(() {});
                  },
                  child: Container(
                    height: 40.h,
                    width: 105.w,
                    decoration: BoxDecoration(
                      color: AppColor.grey1,
                      borderRadius: BorderRadius.circular(100.r),
                      border:
                          widget.type.elementAt(widget.content.indexOf(e)) ==
                                  currentChoice
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
                  ).animate().scale(),
                ))
            .toList());
  }
}
