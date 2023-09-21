import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.instance.initialise();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Recordam',
          routerConfig: routes,
          builder: (context, child) => KeyboardDismisser(
            gestures: const [
              GestureType.onTap,
              GestureType.onVerticalDragDown,
            ],
            child: child!,
          ),
          theme: ThemeData(
            fontFamily: 'Manrope',
          ),
        );
      },
    );
  }
}
