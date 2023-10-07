part of 'update_transaction_cubit.dart';


enum UpdateTransactionStatus { initial, loading, success, error }

class UpdateTransactionState extends Equatable {
  final UpdateTransactionStatus? status;
  final List<Currency>? currencyList;
  final String? selectedCurrency;
  final String? error;
  UpdateTransactionState(
      {this.status, this.currencyList, this.selectedCurrency, this.error});
  factory UpdateTransactionState.initial() => UpdateTransactionState(
        status: UpdateTransactionStatus.initial,
        currencyList: [],
        selectedCurrency: 'Indian Rupee',
        error: '',
      );

  @override
  List<Object?> get props => [status, currencyList, selectedCurrency, error];

  UpdateTransactionState copyWith({
    UpdateTransactionStatus? status,
    List<Currency>? currencyList,
    String? selectedCurrency,
    String? error,
  }) {
    return UpdateTransactionState(
      status: status ?? this.status,
      currencyList: currencyList ?? this.currencyList,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      error: error ?? this.error,
    );
  }
}
