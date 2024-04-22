import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.instance.initialise();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      // splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Recodam',
          routerConfig: routes,
          builder: (context, child) => Column(
            children: [
              Consumer(
                builder: (context, ref, _) {
                  final sending = ref.watch(sendingProvider);
                  return Visibility(
                    visible: sending,
                    child: LinearProgressIndicator(
                      minHeight: 50.h,
                      color: AppColor.red30,
                      backgroundColor: AppColor.red60,
                    ),
                  );
                },
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: child!,
                ),
              ),
            ],
          ),
          theme: ThemeData(
            useMaterial3: false,
            fontFamily: 'Manrope',
            colorSchemeSeed: AppColor.red60,
            scaffoldBackgroundColor: AppColor.white,
            datePickerTheme: DatePickerThemeData(
              surfaceTintColor: AppColor.white,
            ),
          ),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
