import 'package:recordam/utils/utils.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder(
        tween: ColorTween(
          begin: AppColor.red30,
          end: AppColor.red60,
        ), 
        duration: const Duration(seconds: 4),
        builder: (context, color, _) {
          return CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(color),
          );
        },
      ),
    );
  }
}
