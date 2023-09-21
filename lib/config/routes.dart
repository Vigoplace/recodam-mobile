import 'package:recordam/utils/utils.dart';

class FadeTransitionPage extends CustomTransitionPage {
  const FadeTransitionPage({
    required super.child,
    required super.key,
  }) : super(transitionsBuilder: _transitionsBuilder);

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
}

final GoRouter routes = GoRouter(
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
        return FadeTransitionPage(
          child: const OnboardingScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: SignupScreen.path,
      name: SignupScreen.name,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const SignupScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: LoginScreen.path,
      name: LoginScreen.name,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const LoginScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: HomeScreen.path,
      name: HomeScreen.name,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const HomeScreen(),
          key: state.pageKey,
        );
      },
    ),
  ],
);
