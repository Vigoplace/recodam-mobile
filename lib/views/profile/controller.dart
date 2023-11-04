import 'package:recordam/utils/utils.dart';
import 'package:recordam/views/profile/widget.dart';
part 'view.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static const path = "profile";
  static const name = "profile";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => ProfileController();
}

class ProfileController extends ConsumerState<ProfileScreen> {
  late TextEditingController nameController;

  void changePhoto() {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
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
    if (xFile != null) {
      PostRequest.instance.uploadPhoto(ref: ref, file: File(xFile.path)).then(
        (file) {
          LocalStorage.instance.setProfilePhoto(file).then(
              (value) => ref.read(profilePhotoProvider.notifier).state = value);
          ShowFlushBar.showSuccess(
            context: context,
            message: 'Successfully uploaded',
          );
        },
      ).catchError(
        (onError) {
          nameController.clear();
          ref.read(sendingProvider.notifier).state = false;
          listenError(context: context, error: onError);
        },
      );
    }
  }

  void changeName() async {
    nameController.text = LocalStorage.instance.getName();
    var decision = await showDialog(
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
              CustomTextInput(
                controller: nameController,
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
                  GestureDetector(
                    onTap: () => context.pop(true),
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.light100,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate().moveY(),
    );
    if (decision == true) {
      if (nameController.text.isNotEmpty) {
        PostRequest.instance
            .updateProfile(
          ref: ref,
          name: nameController.text,
        )
            .then(
          (message) {
            LocalStorage.instance
                .setName(nameController.text)
                .then((value) => ref.read(nameProvider.notifier).state = value);
            nameController.clear();
            ShowFlushBar.showSuccess(
              context: context,
              message: message,
            );
          },
        ).catchError(
          (onError) {
            nameController.clear();
            ref.read(sendingProvider.notifier).state = false;
            listenError(context: context, error: onError);
          },
        );
      }
    }
  }

  void logOut() async {
    var decision = await showDialog<bool?>(
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
                    onTap: () => context.pop(false),
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
                  GestureDetector(
                    onTap: () async {
                      context.pop(true);
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.red60,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate().moveY(),
    );
    if (decision == true) {
      GetRequest.instance.logout(ref: ref).then(
        (message) {
          SocketServices.instance.disconnect();
          ShowFlushBar.showSuccess(
            context: context,
            message: message,
            perform: () => context.goNamed(LoginScreen.name),
          );
        },
      ).catchError(
        (onError) {
          nameController.clear();
          ref.read(sendingProvider.notifier).state = false;
          listenError(context: context, error: onError);
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileView(this);
  }
}
