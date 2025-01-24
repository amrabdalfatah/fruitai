import 'package:fruitvision/widgets/bottom_navigation.dart';
import 'package:fruitvision/screens/auth/login_screen.dart';
import 'package:fruitvision/screens/auth/register_screen.dart';
import 'package:fruitvision/screens/welcome/body.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => MainScreen(),
    ),
    GoRoute(
      path: '/signin',
      name: 'signin',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/verification',
      name: 'verification',
      builder: (context, state) => const SignInScreen(),
    ),
  ],
);
