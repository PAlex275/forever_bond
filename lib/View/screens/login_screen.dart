import 'package:flutter/material.dart';
import 'package:forever_bond/View/widgets/google_signin_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: GoogleSignInButton(),
      ),
    );
  }
}
