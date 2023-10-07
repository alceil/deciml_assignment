import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deciml_assignment/models/currency_model.dart';
import 'package:deciml_assignment/models/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:http/http.dart' as http;

class FinRepository {
// final dio = Dio();
  var box = Hive.box('Currencies');
  
  final String BASE_URL =
      'https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_HE6juCQyQ2woEr7VS3DrK1chIaikIz3cxt3xUYG7&base_currency=INR';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'transactions';
  final _firebaseAuth = FirebaseAuth.instance;

  Future<List<Transactionn>> getAllTransactions() async {
    var currencyData = box.get('currentCurrency',defaultValue:{
      "symbol": "Rs",
      "name": "Indian Rupee",
      "code": "INR",
   } ) ?? {};
    final user = _firebaseAuth.currentUser;
    final userRef = firestore.collection("users").doc(user?.uid);
    final convertingValue = currencyData['value'] ?? 1.0 as double;
    final snapshot = await userRef.collection(_collectionPath).get();
    final transactions = snapshot.docs
        .map(
            (doc) => Transactionn.fromJson(doc.data(), doc.id))
        .toList();
    return transactions;
  }

    Future<Map<String, dynamic>> getAccountDetails() async {
    final user = _firebaseAuth.currentUser;
    final userRef = firestore.collection("users").doc(user?.uid);
    final snapshot = await userRef.get();
final Map<String, dynamic> accountDetails = {
          'name': snapshot.get('name'),
          'email': snapshot.get('email'),
        };
        return accountDetails;
  }

  Future<void> addTransaction({Transactionn? transaction}) async {
    final user = _firebaseAuth.currentUser;
    final userRef = firestore.collection("users").doc(user?.uid);
    await userRef.collection(_collectionPath).add(transaction!.toJson());
  }

  Future<void> updateTransaction({Transactionn? transaction}) async {
    final user = _firebaseAuth.currentUser;
    final userRef = firestore.collection("users").doc(user?.uid);
    await userRef
        .collection(_collectionPath)
        .doc(transaction!.id!)
        .update(transaction.toJson());
  }
  
  Future<void> updateProfileDetails({String? name}) async {
    final user = _firebaseAuth.currentUser;
    await  firestore.collection("users").doc(user?.uid).update({"name":name});
  }

  Future<void> getCurrencyDetails() async {
      var currencyData = box.get('currentCurrency',defaultValue:{
      "symbol": "Rs",
      "name": "Indian Rupee",
      "code": "INR",
   } ) ?? {};
    print("fetched currency details");
    print(currencyData["code"]);
    final queryParameters = {
      'apikey': 'fca_live_HE6juCQyQ2woEr7VS3DrK1chIaikIz3cxt3xUYG7',
      'base_currency': currencyData["code"]??'INR'
    };
    final uri =
        Uri.https('api.freecurrencyapi.com', '/v1/latest', queryParameters);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['data'];
      box.put('currencyRates', data);
    }
  }

  Future<List<Currency>> getCurrencyList() async {
    final queryParameters = {
      'apikey': 'fca_live_HE6juCQyQ2woEr7VS3DrK1chIaikIz3cxt3xUYG7',
    };
    final uri =
        Uri.https('api.freecurrencyapi.com', '/v1/currencies', queryParameters);
    final response = await http.get(uri);
    print(response);
    Map<String, dynamic> data = json.decode(response.body)['data'];
    return data.entries
        .map((e) => Currency.fromJson(e.value as Map<String, dynamic>))
        .toList();
  }
}
