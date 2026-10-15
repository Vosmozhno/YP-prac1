import 'package:go_router/go_router.dart';

import 'screens/calculator_result_screen.dart';
import 'screens/calculator_screen.dart';
import 'screens/converter_result_screen.dart';
import 'screens/converter_screen.dart';
import 'screens/home_screen.dart';
import 'screens/not_found_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/calculator',
      builder: (context, state) => const CalculatorScreen(),
      routes: [
        GoRoute(
          path: 'result',
          builder: (context, state) =>
              const CalculatorResultScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/converter',
      builder: (context, state) => const ConverterScreen(),
      routes: [
        GoRoute(
          path: 'result',
          builder: (context, state) =>
              const ConverterResultScreen(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => NotFoundScreen(
    location: state.uri.toString(),
  ),
);
