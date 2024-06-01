import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forever_bond/View/bloc/expenses_bloc/expenses_bloc.dart';
import 'package:forever_bond/View/bloc/googel_login_cubit/google_auth_cubit.dart';

import 'package:forever_bond/View/bloc/guests_bloc/guests_bloc.dart';
import 'package:forever_bond/ViewModel/expense_vm.dart';
import 'package:forever_bond/ViewModel/guest_vm.dart';
import 'package:forever_bond/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GoogleAuthCubit(),
        ),
        BlocProvider<GuestsBloc>(
          create: (context) => GuestsBloc(guestViewModel: GuestVM()),
        ),
        BlocProvider<ExpensesBloc>(
          create: (context) =>
              ExpensesBloc(expenseViewModel: ExpenseViewModel()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Forever Bond',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: '.SF UI',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
