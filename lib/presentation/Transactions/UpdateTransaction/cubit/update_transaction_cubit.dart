
import 'package:bloc/bloc.dart';
import 'package:deciml_assignment/data/repositories/finances/finance_repository.dart';
import 'package:deciml_assignment/models/currency_model.dart';
import 'package:deciml_assignment/models/transaction_model.dart';
import 'package:deciml_assignment/presentation/Transactions/cubit/transaction_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'update_transaction_state.dart';

class UpdateTransactionCubit extends Cubit<UpdateTransactionState> {
      final FinRepository _finRepository;
       final TransactionCubit _transactionCubit;
  UpdateTransactionCubit({FinRepository? finRepository,TransactionCubit? transactionCubit}) :
    _finRepository = finRepository ?? FinRepository(),
       _transactionCubit = transactionCubit ?? TransactionCubit(),
   super(UpdateTransactionState.initial());
      var box = Hive.box('Currencies');


    Future<void> updateTransaction({Transactionn? transaction}) async {
      print("update transcation called");
       emit(state.copyWith(status: UpdateTransactionStatus.loading));
      try {
        await _finRepository.updateTransaction(transaction:transaction);
        emit(state.copyWith(status: UpdateTransactionStatus.success));
        print(state.status);
      } catch (e) {
        emit(state.copyWith(status: UpdateTransactionStatus.error));
      }

      print(state.status);
  }

  void fetchCurrencies() async{
  List<Currency> currencies;
  if (box.containsKey('currencies')) {
    currencies = List<Currency>.from(box.get('currencies'));
  } else {
    currencies = await _finRepository.getCurrencyList();
    box.put('currencies', currencies);
  }

  emit(state.copyWith(currencyList: currencies));
}
}
