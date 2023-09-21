import 'package:recordam/utils/utils.dart';

Future<T?> showBottomModal<T>({
  required BuildContext context,
  required String title,
  required Column child,
  String? description,
  bool isScrollControlled = false,
}) async =>
    await showModalBottomSheet<T?>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      isScrollControlled: isScrollControlled,
      context: context,
      builder: (_) => Padding(
        padding: [20, 30, 20, kBottomNavigationBarHeight].pad,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: CustomTextStyle.text500_25.withColor(
                    AppColor.color353535,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    'Close',
                    style: CustomTextStyle.text500_14.withColor(
                      AppColor.color353535,
                    ),
                  ),
                ),
              ],
            ),
            if (description != null)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  18.sbH,
                  Text(
                    description,
                    style: CustomTextStyle.text400_14.withColor(
                      AppColor.color808080,
                    ),
                  ),
                ],
              ),
            24.sbH,
            ...child.children,
          ],
        ),
      ),
    );
