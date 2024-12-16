import 'package:recordam/utils/utils.dart';

class EmptyWidget extends StatelessWidget {
  final String? text;
  final String? subText;
  const EmptyWidget({
    super.key,
    this.text,
    this.subText,
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
                24.verticalSpacing,
                Text(
                  text!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.spMin,
                    color: AppColor.grey50,
                  ),
                ),
                if (subText != null) ...[
                  12.verticalSpacing,
                  Text(
                    subText!,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12.spMin,
                      color: AppColor.grey50,
                    ),
                  ),
                ]
              ],
            ),
        ],
      ),
    );
  }
}
