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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 51.h,
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
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
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColor.red60,
                        child: SvgPicture.asset(AppSvg.camera),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            62.verticalSpace,
            Padding(
              padding: [8, 16, 14, 16].pad,
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppSvg.user,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20.0),
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.grey),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "Name",
                    style: TextStyle(
                      fontFamily: "Manrope",
                    ),
                  ),
                  // 32.horizontalSpace,
                  SizedBox(
                    width: 195,
                  ),
                  Icon(
                    Icons.edit,
                    color: Color.fromARGB(255, 161, 45, 45),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 130, top: 10, bottom: 10),
              child: Text("Eurocode Adam",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Manrope',
                      fontSize: 16)),
            ),
            // 32.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Divider(
                color: AppColor.dark10,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 20.0),
              child: Row(
                children: [
                  Icon(Icons.email, color: Colors.grey),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(
                      fontFamily: "Manrope",
                    ),
                  ),
                  // 32.horizontalSpace,
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 120, top: 10, bottom: 10),
              child: Text("eurocode@gmail.com",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Divider(
                color: AppColor.dark10,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 20.0),
              child: Row(
                children: [
                  Icon(
                    Icons.logout_sharp,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                      fontFamily: "Manrope",
                    ),
                  ),
                  // 32.horizontalSpace,
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 125, top: 10, bottom: 10),
              child: Text("Sign out of the app",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Divider(
                color: AppColor.dark10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
