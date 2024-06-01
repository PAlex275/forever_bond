import 'package:flutter/material.dart';
import 'package:forever_bond/View/screens/expenses_screen.dart';
import 'package:forever_bond/View/screens/guests_screen.dart';
import 'package:forever_bond/View/screens/table_planner_screen.dart';
import 'package:forever_bond/View/widgets/google_signout_button.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const GoogleSignOutButton(),
            TextButton(
              onPressed: () => {
                GoRouter.of(context).push(GuestsScreen.routeName),
              },
              child: const Text('Guest Screen'),
            ),
            TextButton(
              onPressed: () => {
                GoRouter.of(context).push(ExpensesScreen.routeName),
              },
              child: const Text('Expenses Screen'),
            ),
            TextButton(
              onPressed: () => {
                GoRouter.of(context).push(TablePlannerScreen.routeName),
              },
              child: const Text('Table Planner Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
