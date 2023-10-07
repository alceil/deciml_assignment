import 'package:deciml_assignment/models/transaction_model.dart';
import 'package:deciml_assignment/presentation/Transactions/UpdateTransaction/UpdateTransactions.dart';
import 'package:deciml_assignment/presentation/Transactions/cubit/transaction_cubit.dart';
import 'package:deciml_assignment/presentation/Transactions/widgets/SearchBar.dart';
import 'package:deciml_assignment/presentation/Transactions/widgets/TransactionFilters.dart';
import 'package:deciml_assignment/shared/global/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    final transactionCubit = context.read<TransactionCubit>();
    context.read<TransactionCubit>().getAllTransactions();
    final Globals _global = Globals();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).textTheme.bodyLarge!.color,
          title: const Text("Transactions"),
          centerTitle: true,
        ),
        body: BlocListener<TransactionCubit, TransactionState>(
          listener: (context, state) {
            print('New state: $state');

            if (state.status == TransactionStatus.error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error!)));
            }
          },
          child: BlocBuilder<TransactionCubit, TransactionState>(
            builder: (context, state) {
              if (state.status == TransactionStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.status == TransactionStatus.initial) {
                return const Center(
                  child: Text("No Transactions"),
                );
              }

              if (state.status == TransactionStatus.loaded) {
                return Column(
                  children: [
                    SearchTransactionsBar(
                      controller: search,
                      onChanged: (val) =>
                          transactionCubit.searchTransactions(val),
                    ),
                    const TransactionFilter(),
                    state.transactionss!.isEmpty?
                    Center(child: Text("No transactions ")):
                    Flexible(
                      child: ListView.builder(
                          itemCount: state.transactionss!.length,
                          itemBuilder: (context, index) {
                            final transactionData = state.transactionss?[index];
                            return GestureDetector(
                              onTap: () async {
                                
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateTransactionsScreen(
                                                data: transactionData)));

                                                    context.read<TransactionCubit>().getAllTransactions();
                              },
                              child: ListTile(
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "${state.transactionss![index].type=='E'?"-":""} ${_global.getSymbolByName(state.transactionss![index].currency ?? '')} ${state.transactionss![index].amount.toString()}",
                                        style:
                                        Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,
                  color:state.transactionss![index].type=='I'?Colors.green:Colors.red),
            ),
            Text(_global.convertDate(state.transactionss![index].date!))
                                  ],
                                ),
                                    
                                     
          
                                title: Text(state.transactionss![index].name!),
                                subtitle: Text(
                                    state.transactionss![index].description!),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
