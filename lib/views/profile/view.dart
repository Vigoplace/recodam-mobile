part of 'controller.dart';

class ProfileView extends StatelessView<ProfileScreen, SampleController> {
  const ProfileView(SampleController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        elevation: 0.0,
        
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: <Widget>[Text("hello")],
        ),
      ),
    );
  }
}
