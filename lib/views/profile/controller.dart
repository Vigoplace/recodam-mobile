import 'package:recordam/utils/utils.dart';
part 'view.dart';

class ProfileScreen extends StatefulWidget {
  static const path = "profile";
  static const name = "profile";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileController();
}

class ProfileController extends State<ProfileScreen> {
  
  @override
  Widget build(BuildContext context) {
    return ProfileView(this);
  }
}
