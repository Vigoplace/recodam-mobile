import 'package:recordam/utils/utils.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? centerTitle;
  final List<Widget> action;
  const CustomAppbar({
    super.key,
    this.title,
    this.centerTitle,
    this.action = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: RoundIconButton(
        icon: AppSvg.directionRight,
        onTap: () => context.pop(),
        paddingLeft: 16,
      ),
      centerTitle: centerTitle,
      leadingWidth: 80,
      elevation: 0,
      actions: [
        ...action,
        16.horizontalSpacing,
      ],
      backgroundColor: AppColor.white,
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 18.spMin,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size(0, kToolbarHeight);
}
