import 'package:bloc/bloc.dart';
import 'package:deciml_assignment/data/repositories/auth/auth_repository.dart';
import 'package:deciml_assignment/data/repositories/finances/finance_repository.dart';
import 'package:deciml_assignment/models/currency_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final FinRepository _finRepository;
    final AuthRepository _authRepository;
  AccountCubit({FinRepository? finRepository,AuthRepository? authRepository})
      : _finRepository = finRepository ?? FinRepository(),
      _authRepository = authRepository ?? AuthRepository()
      ,
        super(AccountState.initial());

  var box = Hive.box('Currencies');

  void changeCurrency(Currency currency) {
    emit(state.copyWith(selectedCurrency: currency.name));
    final mappedData = box.get('currencyRates',defaultValue:{
      "symbol": "Rs",
      "name": "Indian Rupee",
      "code": "INR",
   } );
box.put('currentCurrency',{
  "name":currency.name,
  "symbol":currency.symbol,
  "code":currency.code,
  "value":mappedData[currency.code]
});
getCurrencyDetails();
  }


  Future<void> getCurrencyDetails() async{
    await _finRepository.getCurrencyDetails();
  }
  Future<void> getAccountDetails() async{
    final mappedData = box.get('currentCurrency',defaultValue:{
      "symbol": "Rs",
      "name": "Indian Rupee",
      "code": "INR",
   } )??{};
   emit(state.copyWith(status: AccountStatus.loading));
   print("fetched account details");
    try {
      final userDetails = await _finRepository.getAccountDetails() as Map<String,dynamic>;
      print(userDetails);
      emit(state.copyWith(
          status: AccountStatus.loaded, name:userDetails["name"],email: userDetails["email"],selectedCurrency: mappedData["name"]??''));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: AccountStatus.error));
    }finally{
      getCurrencyRates();
    }
  }
  Future<void> getCurrencyRates() async {
    emit(state.copyWith(status: AccountStatus.loading));
    try {
      final currencyList = await _finRepository.getCurrencyList();
      emit(state.copyWith(
          status: AccountStatus.loaded, currencyList: currencyList));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: AccountStatus.error));
    } finally {
      await _finRepository.getCurrencyDetails();
    }
  }

   Future<void> updateProfile({String? name}) async {
      print("update transcation called");
       emit(state.copyWith(status: AccountStatus.loading));
       print(name);
      try {
        await _finRepository.updateProfileDetails(name: name);
        emit(state.copyWith(status: AccountStatus.loaded,name: name));
        print(state.status);
      } catch (e) {
        emit(state.copyWith(status: AccountStatus.error));
      }
  }
}
