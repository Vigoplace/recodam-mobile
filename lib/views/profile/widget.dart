import 'package:recordam/utils/utils.dart';

class ProfileDetail extends StatelessWidget {
  final String name;
  final String value;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  const ProfileDetail({
    super.key,
    required this.name,
    required this.value,
    required this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: [8, 16, 14, 16].pad,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: prefixIcon,
              ),
              16.horizontalSpacing,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14.spMin,
                      fontWeight: FontWeight.w400,
                      color: AppColor.grey40,
                    ),
                  ),
                  8.verticalSpacing,
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.grey100,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (suffixIcon != null) suffixIcon!,
            ],
          ),
        ),
        Divider(
          color: AppColor.dark10,
        )
      ],
    );
  }
}
