part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, loading, loaded, error }

class DashboardState extends Equatable {
  final DashboardStatus? status;
  final int? income;
  final int? expense;
  final int? totalAmount;
  final String? currencyCode;
  final String? error;
  const DashboardState(
      {this.status,
      this.income,
      this.expense,
      this.totalAmount,
      this.currencyCode,
      this.error});
  factory DashboardState.initial() => const DashboardState(
      status: DashboardStatus.initial,
      income: 0,
      expense: 0,
      totalAmount: 0,
      currencyCode: '');

  @override
  List<Object?> get props => [status, income, expense, totalAmount];

  DashboardState copyWith(
      {DashboardStatus? status,
      int? income,
      int? expense,
      int? totalAmount,
      String? error,
      String? currencyCode}) {
    return DashboardState(
      status: status ?? this.status,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      totalAmount: totalAmount ?? this.totalAmount,
      currencyCode: currencyCode ?? this.currencyCode,
      error: error ?? this.error,
    );
  }
}
