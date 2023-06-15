
import 'package:aplikasi_point_of_sales/core/router/app_routes.dart';
import 'package:aplikasi_point_of_sales/screen/auth/login_screen.dart';
import 'package:aplikasi_point_of_sales/screen/auth/register_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter returnRouter() {
    GoRouter router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
            name: AppRoutes.login,
            path: '/',
            builder: (context, state) => const LoginScreen()),
        GoRoute(
            path: AppRoutes.register,
            builder: (context, state) => const RegisterScreen())
      ],
    );
    return router;
  }
}
