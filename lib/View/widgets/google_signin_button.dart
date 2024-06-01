import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forever_bond/View/bloc/googel_login_cubit/google_auth_cubit.dart';

import 'package:forever_bond/View/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleAuthCubit, GoogleAuthState>(
      listener: (context, state) {
        if (state is GoogleAuthNavigateToHome) {
          GoRouter.of(context).pushReplacement(HomeScreen.routeName);
        }
      },
      child: SizedBox(
        width: 140,
        height: 40,
        child: TextButton(
          onPressed: () {
            context.read<GoogleAuthCubit>().login();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return Colors.blue;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 2),
            ),
          ),
          child: const Text(
            'Sign in with Google',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
