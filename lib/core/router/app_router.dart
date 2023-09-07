import 'package:cash_whiz/core/router/app_routes.dart';
import 'package:cash_whiz/screen/home/homescreen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter returnRouter() {
    GoRouter router = GoRouter(
      routes: <RouteBase>[
        // GoRoute(
        //     name: AppRoutes.login,
        //     path: '/',
        //     builder: (context, state) => const LoginScreen()),
        // GoRoute(
        //     path: AppRoutes.register,
        //     builder: (context, state) => const RegisterScreen()),
        GoRoute(
            name: AppRoutes.homescreen,
            path: '/',
            builder: (context, state) => const HomeScreen()),
      ],
    );
    return router;
  }
}
