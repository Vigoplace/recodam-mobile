import 'package:recordam/utils/utils.dart';
import 'package:recordam/views/profile/widget.dart';
part 'view.dart';

class ProfileScreen extends StatefulWidget {
  static const path = "profile";
  static const name = "profile";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileController();
}

class ProfileController extends State<ProfileScreen> {
  void changePhoto() {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      builder: (context) => Padding(
        padding: [16, 0, 0, 0].pad,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Profile photo",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColor.light100,
              ),
            ),
            18.verticalSpace,
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () => selectImage(source: ImageSource.camera),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColor.red60,
                    child: SvgPicture.asset(AppSvg.camera),
                  ),
                  16.horizontalSpace,
                  Text(
                    "Camera",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () => selectImage(source: ImageSource.gallery),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColor.red60,
                    child: SvgPicture.asset(AppSvg.gallery),
                  ),
                  16.horizontalSpace,
                  Text(
                    "Gallery",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            50.verticalSpace,
          ],
        ),
      ),
    );
  }

  void selectImage({required ImageSource source}) async {
    Navigator.of(context, rootNavigator: true).pop();
    final ImagePicker picker = ImagePicker();
    var xFile = await picker.pickImage(source: source);
    if (xFile != null) {}
  }

  void changeName() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: [20, 0, 20, 0].pad,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: [16, 21].pad,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Enter new name",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.light100,
                ),
              ),
              10.verticalSpace,
              const CustomTextInput(
                hintText: 'Alicia Williams',
                maxLength: 16,
              ),
              41.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.grey20,
                      ),
                    ),
                  ),
                  40.horizontalSpace,
                  Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.light100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logOut() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: [20, 0, 20, 0].pad,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: [16, 21].pad,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Log out",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              25.verticalSpace,
              Text(
                "Are you sure you want to log out of your account",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.light100,
                ),
              ),
              40.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.grey20,
                      ),
                    ),
                  ),
                  40.horizontalSpace,
                  Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.red60,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProfileView(this);
  }
}
