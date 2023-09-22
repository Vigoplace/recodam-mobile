import 'package:recordam/utils/utils.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? centerTitle;
  const CustomAppbar({
    super.key,
    this.title,
    this.centerTitle,
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
      leadingWidth: 80.w,
      elevation: 0,
      backgroundColor: AppColor.white,
      title: title != null
          ? Text(
              title!,
              style: CustomTextStyle.text700_18.withColor(
                AppColor.grey100,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size(kToolbarHeight, kToolbarHeight);
}
