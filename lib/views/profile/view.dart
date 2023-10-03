part of 'controller.dart';

class ProfileView extends StatelessView<ProfileScreen, ProfileController> {
  const ProfileView(ProfileController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Profile",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  const CircleAvatar(
                    // backgroundColor: Colors.amber,
                    backgroundImage: AssetImage("assets/images/image.png"),
                    radius: 100,
                  ),
                  Positioned(
                    top: 140,
                    left: 145,
                    child: GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 22.0,
                        backgroundColor: Color.fromARGB(255, 161, 45, 45),
                        child: Icon(
                          Icons.camera_alt_sharp,
                          color: Colors.white,
                          size: 25.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              32.verticalSpace,
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
      ),
    );
  }
}
