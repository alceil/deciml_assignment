import 'package:bloc/bloc.dart';
import 'package:deciml_assignment/data/repositories/finances/finance_repository.dart';
import 'package:deciml_assignment/models/transaction_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final FinRepository _finRepository;
  TransactionCubit({FinRepository? finRepository})
      : _finRepository = finRepository ?? FinRepository(),
        super(TransactionState.initial());

  Future<void> getAllTransactions() async {
    emit(state.copyWith(status: TransactionStatus.loading));
    print("Transactions called");
    try {
      final data = await _finRepository.getAllTransactions();
      emit(state.copyWith(
          transactionss: data,
          transactions: data,
          status: TransactionStatus.loaded));
    } catch (e) {
      emit(
          state.copyWith(error: e.toString(), status: TransactionStatus.error));
      emit(TransactionState.initial());
    }
  }

  void searchTransactions(String query) {
    List<Transactionn> filteredList =
        List.from(state.transactions as List<Transactionn>);
    filteredList = state.transactions!
        .where((element) =>
            element.name?.toLowerCase().contains(query.toLowerCase()) ?? true)
        .toList();
    emit(state.copyWith(transactionss: filteredList));
  }

  void changeFilter(String? filter) {
    List<Transactionn> filteredList =
        List.from(state.transactions as List<Transactionn>);

    if (filter == 'All') {
      filteredList = state.transactions!;
    } else if (filter == 'Income') {
      filteredList =
          state.transactions!.where((element) => element.type == 'I').toList();
    } else if (filter == 'Expense') {
      filteredList =
          state.transactions!.where((element) => element.type == 'E').toList();
    }
    emit(state.copyWith(transactionss: filteredList));
  }
}
