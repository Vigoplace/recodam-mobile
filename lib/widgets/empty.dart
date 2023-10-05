import 'package:recordam/utils/utils.dart';

class EmptyWidget extends StatelessWidget {
  final String? text;
  const EmptyWidget({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImages.paper,
          ),
          if (text != null)
            Column(
              children: [
                24.verticalSpace,
                Text(
                  text!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColor.grey50,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
