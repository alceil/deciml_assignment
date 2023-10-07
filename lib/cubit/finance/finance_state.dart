part of 'finance_cubit.dart';

enum FinanceStatus { initial, loading, success, error }

class FinanceState extends Equatable {
  final FinanceStatus? status;
  final List<Currency>? currencyList;
  final String? selectedCurrency;
  final String? error;
  FinanceState(
      {this.status, this.currencyList, this.selectedCurrency, this.error});
  factory FinanceState.initial() => FinanceState(
        status: FinanceStatus.initial,
        currencyList: [],
        selectedCurrency: 'Indian Rupee',
        error: '',
      );

  @override
  List<Object?> get props => [status, currencyList, selectedCurrency, error];

  FinanceState copyWith({
    FinanceStatus? status,
    List<Currency>? currencyList,
    String? selectedCurrency,
    String? error,
  }) {
    return FinanceState(
      status: status ?? this.status,
      currencyList: currencyList ?? this.currencyList,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      error: error ?? this.error,
    );
  }
}
