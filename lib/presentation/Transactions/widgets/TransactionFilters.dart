import 'package:deciml_assignment/presentation/Transactions/cubit/transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionFilter extends StatefulWidget {
  const TransactionFilter({super.key});
  @override
  State<TransactionFilter> createState() => _TransactionFilterState();
}

class _TransactionFilterState extends State<TransactionFilter> {
  List<String> filters = ['All', 'Income', 'Expense'];
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: filters.map((e) {
          int i = filters.indexOf(e);
          return InkWell(
              onTap: () {
                setState(() {
                  activeIndex = i;
                });
                context.read<TransactionCubit>().changeFilter(filters[i]);
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Chip(
                  label: Text(e),
                  labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                  backgroundColor: activeIndex == i ? Color(0xFF8E59FF) : Theme.of(context).brightness == Brightness.light
        ? Colors.grey // Light mode color
        : Colors.grey[800],
                ),
              ));
        }).toList());
  }
}
