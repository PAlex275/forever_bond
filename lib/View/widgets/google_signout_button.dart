import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forever_bond/View/bloc/googel_login_cubit/google_auth_cubit.dart';

import 'package:forever_bond/View/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

class GoogleSignOutButton extends StatelessWidget {
  const GoogleSignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleAuthCubit, GoogleAuthState>(
      listener: (context, state) {
        if (state is GoogleAuthNavigateToLogin) {
          GoRouter.of(context).pushReplacement(LoginScreen.routeName);
        }
      },
      child: SizedBox(
        width: 140,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            context.read<GoogleAuthCubit>().signOut();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return Colors.red; // Color for sign-out button
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          child: const Text(
            'Sign Out',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
