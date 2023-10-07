import 'package:deciml_assignment/cubit/finance/finance_cubit.dart';
import 'package:deciml_assignment/presentation/Account/AccountScreen.dart';
import 'package:deciml_assignment/presentation/Account/cubit/account_cubit.dart';
import 'package:deciml_assignment/presentation/AddTransaction.dart';
import 'package:deciml_assignment/presentation/Dashboard/dashboard.dart';
import 'package:deciml_assignment/presentation/Transactions/TransactionsScreen.dart';
import 'package:deciml_assignment/presentation/Transactions/UpdateTransaction/cubit/update_transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  final List<Widget> pages = [
    const Dashboard(),
    const TransactionsScreen(),
    AccountScreen(),
  ];
  Widget bodyWidget() => pages[index];

  @override
  void initState() {
    context.read<FinanceCubit>().fetchCurrencies();
      context.read<UpdateTransactionCubit>().fetchCurrencies();
    context.read<AccountCubit>().getAccountDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyWidget(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              iconSize: 30,
              icon: const Icon(Icons.home),
              color: index == 0 ? Color(0xFF8E59FF) : Colors.grey,
              onPressed: () => _menuSelected(0),
            ),
            IconButton(
              iconSize: 30,
              icon: const Icon(Icons.my_library_books_outlined),
              color: index == 1 ? Color(0xFF8E59FF) : Colors.grey,
              onPressed: () => _menuSelected(1),
            ),
            IconButton(
              iconSize: 30,
              icon: const Icon(Icons.person),
              color: index == 2 ?Color(0xFF8E59FF) : Colors.grey,
              onPressed: () => _menuSelected(2),
            ),
          ],
        ),
      ),
  
    );
  }

  void _menuSelected(int i) {
    setState(() {
      index = i;
    });
  }
}
