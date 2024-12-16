part of 'controller.dart';

class ProfileView extends StatelessView<ProfileScreen, ProfileController> {
  const ProfileView(super.state, {super.key});

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
              height: 160,
              width: 160,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Consumer(
                      builder: (context, ref, _) {
                        var photo = ref.watch(profilePhotoProvider);
                        return GestureDetector(
                          onTap: () {
                            if (photo == null) return;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ViewImage(
                                  image: photo,
                                  appBarText: 'Profile image',
                                ),
                              ),
                            );
                          },
                          child: photo == null
                              ? const CircleAvatar(
                                  backgroundImage: AssetImage(
                                    AppImages.image,
                                  ),
                                )
                              : ImageLoader(
                                  image: photo,
                                  boxShape: BoxShape.circle,
                                  boxFit: BoxFit.cover,
                                ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: GestureDetector(
                        onTap: controller.changePhoto,
                        child: CircleAvatar(
                          radius: 20,
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
          62.verticalSpacing,
          ProfileDetail(
            name: 'Name',
            value: controller.ref.watch(nameProvider),
            prefixIcon: SvgPicture.asset(AppSvg.user),
            suffixIcon: InkWell(
              onTap: controller.changeName,
              child: SvgPicture.asset(AppSvg.edit),
            ),
          ),
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
