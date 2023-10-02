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
  // initialLocation: HomeScreen.path,
  initialLocation: OnboardingScreen.path,
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    if (state.matchedLocation == OnboardingScreen.path) {
      if (LocalStorage.instance.getLoggedIn()) {
        return HomeScreen.path;
      } else if (LocalStorage.instance.getFirstTime()) {
        return OnboardingScreen.path;
      } else {
        return LoginScreen.path;
      }
    }
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
    GoRoute(
      path: ProfileScreen.path,
      name: ProfileScreen.name,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const ProfileScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: CreateRecordScreen.path,
      name: CreateRecordScreen.name,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const CreateRecordScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: CreateBookScreen.path,
      name: CreateBookScreen.name,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const CreateBookScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: SearchScreen.path,
      name: SearchScreen.name,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const SearchScreen(),
          key: state.pageKey,
        );
      },
    ),
  ],
);
