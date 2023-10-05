part of 'controller.dart';

class ProfileView extends StatelessView<ProfileScreen, ProfileController> {
  const ProfileView(ProfileController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Profile",
        centerTitle: false,
      ),
      body: ListView(
        padding: [16, 51, 16, 0].pad,
        children: <Widget>[
          Center(
            child: SizedBox(
              height: 160.w,
              width: 160.w,
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        AppImages.image,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: GestureDetector(
                        onTap: controller.changePhoto,
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundColor: AppColor.red60,
                          child: SvgPicture.asset(AppSvg.camera),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          62.verticalSpace,
          Builder(builder: (context) {
            var name = LocalStorage.instance.getName();
            return ProfileDetail(
              name: 'Name',
              value: name,
              prefixIcon: SvgPicture.asset(AppSvg.user),
              suffixIcon: InkWell(
                onTap: controller.changeName,
                child: SvgPicture.asset(AppSvg.edit),
              ),
            );
          }),
          Builder(builder: (context) {
            var email = LocalStorage.instance.getEmail();
            return ProfileDetail(
              name: 'Email',
              value: email,
              prefixIcon: SvgPicture.asset(AppSvg.drafts),
            );
          }),
          InkWell(
            onTap: controller.logOut,
            child: ProfileDetail(
              name: 'Logout',
              value: 'Sign out of the app',
              prefixIcon: SvgPicture.asset(AppSvg.logout),
            ),
          ),
        ],
      ),
    );
  }
}
