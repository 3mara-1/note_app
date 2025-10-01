import 'package:go_router/go_router.dart';
import 'package:note_app/features/presentation/screens/register.dart';
import 'package:note_app/features/presentation/screens/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      GoRoute(path: '/register', builder: (context, state) => Register()),
    ],
  );
}
