import 'package:go_router/go_router.dart';
import 'package:note_app/features/presentation/auth/screens/register.dart';
import 'package:note_app/features/presentation/auth/screens/splash_screen.dart';
import 'package:note_app/features/presentation/home/screen/home.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      GoRoute(path: '/register', builder: (context, state) => Register()),
      GoRoute(path: '/home', builder: (context, state) => Home()),

    ],
  );
}
