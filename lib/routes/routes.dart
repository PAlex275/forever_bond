import 'package:flutter/widgets.dart';
import 'package:forever_bond/View/screens/expenses_screen.dart';
import 'package:forever_bond/View/screens/guests_screen.dart';
import 'package:forever_bond/View/screens/home_screen.dart';
import 'package:forever_bond/View/screens/login_screen.dart';
import 'package:forever_bond/View/screens/splash_screen.dart';
import 'package:forever_bond/View/screens/table_planner_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: SplashScreen.routeName,
  routes: <RouteBase>[
    GoRoute(
      path: SplashScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: GuestsScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const GuestsScreen();
      },
    ),
    GoRoute(
      path: HomeScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: ExpensesScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const ExpensesScreen();
      },
    ),
    GoRoute(
      path: TablePlannerScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const TablePlannerScreen();
      },
    ),
  ],
);
