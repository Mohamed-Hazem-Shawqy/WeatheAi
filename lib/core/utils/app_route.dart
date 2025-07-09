import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_ai/features/auth/presentation/view/login.dart';
import 'package:weather_ai/features/auth/presentation/view/signup.dart';
import 'package:weather_ai/features/auth_way_select/presentation/view/auth_way_select.dart';
import 'package:weather_ai/features/home/presentation/views/home.dart';

class AppRoutes {
  static const signup = '/SignUp';
  static const login = '/LogIn';
  static const home = '/Home';
  static const authWaySelect = '/';
  static final routes = GoRouter(
      initialLocation: authWaySelect,
      redirect: (context, state) {
        final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
        final bool isLogInRoute = state.uri.path == login;
        final bool isSignUpRoute = state.uri.path == signup;
        final bool isAuthWaySelect = state.uri.path == authWaySelect;
        if (!isLoggedIn) {
          if (isAuthWaySelect || isLogInRoute || isSignUpRoute) {
            return null;
          }
          return signup;
        }

        if (isLoggedIn) {
          if (isLogInRoute || isSignUpRoute || isAuthWaySelect) {
            return home;
          }
        }

        return null;
      },
      routes: [
        GoRoute(
          path: authWaySelect,
          builder: (context, state) => const AuthWaySelect(),
        ),
        GoRoute(
          path: signup,
          builder: (context, state) => const Signup(),
        ),
        GoRoute(
          path: login,
          builder: (context, state) => const Login(),
        ),
        GoRoute(
          path: home,
          builder: (context, state) => const Home(),
        )
      ]);
}
