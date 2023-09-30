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
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.amber,
                  backgroundImage: AssetImage("assets/image.png"),
                  radius: 75,
                ),
                Positioned(
                  top: 60,
                  left: 80,
                  child: GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      radius: 15.0,
                      backgroundColor: Color.fromARGB(255, 45, 161, 49),
                      child: Icon(
                        Icons.camera_alt_sharp,
                        color: Color.fromARGB(255, 247, 245, 245),
                        size: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
