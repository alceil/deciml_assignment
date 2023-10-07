import 'package:deciml_assignment/cubit/auth/auth_cubit.dart';
import 'package:deciml_assignment/cubit/finance/finance_cubit.dart';
import 'package:deciml_assignment/cubit/theme/theme_cubit.dart';
import 'package:deciml_assignment/data/repositories/finances/finance_repository.dart';
import 'package:deciml_assignment/models/currency_model.dart';
import 'package:deciml_assignment/presentation/Account/cubit/account_cubit.dart';
import 'package:deciml_assignment/presentation/Dashboard/cubit/dashboard_cubit.dart';
import 'package:deciml_assignment/presentation/Dashboard/dashboard.dart';
import 'package:deciml_assignment/presentation/Home.dart';
import 'package:deciml_assignment/presentation/SignIn/sign_in.dart';
import 'package:deciml_assignment/presentation/Transactions/UpdateTransaction/cubit/update_transaction_cubit.dart';
import 'package:deciml_assignment/presentation/Transactions/cubit/transaction_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CurrencyAdapter());
  await Hive.openBox('Auth');
  await Hive.openBox('Currencies');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => DashboardCubit(),
        ),
        BlocProvider(
          create: (context) => FinanceCubit()..fetchCurrencies(),
        ),
                BlocProvider(
          create: (context) => UpdateTransactionCubit()..fetchCurrencies(),
        ),
        BlocProvider(
          create: (context) => TransactionCubit()..getAllTransactions(),
        ),
        BlocProvider(
          create: (context) => AccountCubit()..getAccountDetails(),
        ),
        
                BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: state.themeMode,
            home: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                  if (snapshot.hasData) {
                    return const Home();
                  }
                  // Otherwise, they're not signed in. Show the sign in page.
                  return const SignIn();
                }),
          );
        },
      ),
    );
  }
}
