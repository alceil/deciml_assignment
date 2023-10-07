import 'package:bloc/bloc.dart';
import 'package:deciml_assignment/data/repositories/finances/finance_repository.dart';
import 'package:deciml_assignment/models/transaction_model.dart';
import 'package:deciml_assignment/shared/global/globals.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final FinRepository _finRepository;
  DashboardCubit({FinRepository? finRepository})
      : _finRepository = finRepository ?? FinRepository(),
        super(DashboardState.initial());
  final box = Hive.box('Currencies');
  final Globals nameConvertor = Globals();

  Future<void> getTransactionStats() async {
    int income = 0;
    int expense = 0;
        final mappedData = box.get('currencyRates');
    emit(state.copyWith(status: DashboardStatus.loading));
    try {
         
      final data = await _finRepository.getAllTransactions();
   data.forEach((e) {
    final currencyCode = nameConvertor.getCodeByName(e.currency!);
    print(mappedData[currencyCode]);

    final convertingValue = (mappedData[currencyCode] as num).toDouble();
    
    print(convertingValue);

    if (e.type == 'I') {
      income += ((e.amount ?? 0).toDouble() ~/ convertingValue).toInt();
    } else if (e.type == 'E') {
      expense += ((e.amount ?? 0).toDouble() ~/ convertingValue).toInt();
    }
  });
   var currencyData = box.get('currentCurrency',defaultValue:{
      "symbol": "Rs",
      "name": "Indian Rupee",
      "code": "INR",
   } ) ?? {};
      emit(state.copyWith(
          status: DashboardStatus.loaded,
          totalAmount: income - expense,
          income: income,
          expense: expense,
          currencyCode: currencyData['symbol'] ?? ''));
    } catch (e) {
      emit(state.copyWith(status: DashboardStatus.error, error: e.toString()));
      emit(DashboardState.initial());
    }
  }
}
