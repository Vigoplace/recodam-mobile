import 'package:recordam/utils/utils.dart';

final GoRouter routes = GoRouter(
  // initialLocation: MainScreen.path,
  initialLocation: OnboardingScreen.path,
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    return null;
  },
  routes: [
    GoRoute(
      path: OnboardingScreen.path,
      name: OnboardingScreen.name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);
