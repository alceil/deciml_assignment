part of 'account_cubit.dart';

enum AccountStatus { initial, loading, loaded, error }

class AccountState extends Equatable {
  final AccountStatus? status;
  final String? name;
    final String? email;
  final String? selectedCurrency;
  final String? error;
  final List<Currency>? currencyList;
  const AccountState(
      {this.status, this.selectedCurrency, this.error, this.currencyList,this.email,this.name});
  factory AccountState.initial() => const AccountState(
      status: AccountStatus.initial, selectedCurrency: '', currencyList: [],name: '',email: '');

  @override
  List<Object?> get props => [status, selectedCurrency,error,name,currencyList,email];

  AccountState copyWith(
      {AccountStatus? status,
      String? selectedCurrency,
      String? error,
            String? email,
                  String? name,
      List<Currency>? currencyList}) {
    return AccountState(
        status: status ?? this.status,
        selectedCurrency: selectedCurrency ?? this.selectedCurrency,
        currencyList: currencyList ?? this.currencyList,
        error: error ?? this.error,
               email: email ?? this.email,
                      name: name ?? this.name,
        
        );
  }
}
