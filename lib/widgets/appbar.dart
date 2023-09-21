import 'package:recordam/utils/utils.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: RoundIconButton(
        icon: AppSvg.directionRight,
        onTap: () => context.pop(),
        paddingLeft: 16,
      ),
      leadingWidth: 80.w,
      elevation: 0,
      backgroundColor: AppColor.white,
    );
  }

  @override
  Size get preferredSize => const Size(kToolbarHeight, kToolbarHeight);
}
