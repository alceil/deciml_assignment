part of 'transaction_cubit.dart';

enum TransactionStatus { initial, loading, loaded, error }

class TransactionState extends Equatable {
  final TransactionStatus? status;
  final List<Transactionn>? transactions;
  final List<Transactionn>? transactionss;
  final String? error;
  TransactionState(
      {this.status, this.transactions, this.transactionss, this.error});
  factory TransactionState.initial() => TransactionState(
        status: TransactionStatus.initial,
        transactions: [],
        transactionss: [],
        error: '',
      );

  @override
  List<Object?> get props => [status, transactions, transactionss, error];

  TransactionState copyWith(
      {TransactionStatus? status,
      List<Transactionn>? transactions,
      List<Transactionn>? transactionss,
      String? error,
      int? activeIndex,
      List<String>? filters}) {
    return TransactionState(
        status: status ?? this.status,
        transactions: transactions ?? this.transactions,
        error: error ?? this.error,
        transactionss: transactionss ?? this.transactionss);
  }
}
