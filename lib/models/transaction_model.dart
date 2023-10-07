import 'package:cloud_firestore/cloud_firestore.dart';

class Transactionn {
  final String? name;
  final String? description;
  String? id;
  final int? amount;
  final String? category;
  final String? date;
  final String? type;
  late final String? currency;

  Transactionn(
      {this.name,
      this.description,
      this.id,
      this.amount,
      this.date,
      this.category,
      this.type,
      this.currency});

  static Transactionn fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Transactionn(
      name: snapshot['name'],
      description: snapshot['description'],
      id: snapshot['id'],
      amount: snapshot['amount'],
      date: snapshot['date'],
      category: snapshot['category'],
      type: snapshot['type'],
      currency: snapshot['currency'],
    );
  }

  factory Transactionn.fromJson(
          Map<String, dynamic> json, String id) =>
      Transactionn(
        name: json["name"],
        description: json["description"],
        id: id,
        amount:json['amount'],
        date: json['date'],
        category: json['category'],
        type: json['type'],
        currency: json['currency'],
      );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "amount": amount,
      "date": date,
      "category": category,
      "type": type,
      "currency": currency,
    };
  }
}
