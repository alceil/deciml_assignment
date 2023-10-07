import 'package:bloc/bloc.dart';
import 'package:deciml_assignment/data/repositories/finances/finance_repository.dart';
import 'package:deciml_assignment/models/currency_model.dart';
import 'package:deciml_assignment/models/transaction_model.dart';
import 'package:deciml_assignment/presentation/Transactions/cubit/transaction_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'finance_state.dart';

class FinanceCubit extends Cubit<FinanceState> {
      final FinRepository _finRepository;
       final TransactionCubit _transactionCubit;
  FinanceCubit({FinRepository? finRepository,TransactionCubit? transactionCubit}) :
    _finRepository = finRepository ?? FinRepository(),
       _transactionCubit = transactionCubit ?? TransactionCubit(),
   super(FinanceState.initial());
      var box = Hive.box('Currencies');

  Future<void> addTransaction({Transactionn? transaction}) async {
    print("add transaction triggered");
       emit(state.copyWith(status: FinanceStatus.loading));
      try {
        await _finRepository.addTransaction(transaction:transaction);
        emit(state.copyWith(status: FinanceStatus.success));
      } catch (e) {
        emit(state.copyWith(status: FinanceStatus.error));
      }
  }

    Future<void> updateTransaction({Transactionn? transaction}) async {
      print("update transcation called");
       emit(state.copyWith(status: FinanceStatus.loading));
      try {
        await _finRepository.updateTransaction(transaction:transaction);
        emit(state.copyWith(status: FinanceStatus.success));
        print(state.status);
      } catch (e) {
        emit(state.copyWith(status: FinanceStatus.error));
      }finally{
             emit(state.copyWith(status: FinanceStatus.initial));
      }
  }

    void changeCurrency(Currency currency) {
    emit(state.copyWith(selectedCurrency: currency.name,status: FinanceStatus.initial));
  }


  void fetchCurrencies() async{
    print("fetched currencies");
  // Check if currencies are already stored in Hive
  List<Currency> currencies;
  if (box.containsKey('currencies')) {
    currencies = List<Currency>.from(box.get('currencies'));
  } else {
    // Fetch and save currencies for the first time
    currencies = await _finRepository.getCurrencyList();
    box.put('currencies', currencies);
  }

  emit(state.copyWith(currencyList: currencies));
}
}
