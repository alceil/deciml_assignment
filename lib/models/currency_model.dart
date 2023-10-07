import 'package:hive/hive.dart';
part 'currency_model.g.dart';

@HiveType(typeId: 1)
class Currency {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? symbol;
  @HiveField(2)
  final String? code;
  Currency({this.name, this.symbol, this.code});
  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json['name'],
        symbol: json['symbol'],
        code: json['code'],
      );

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "symbol": symbol,
      "code": code,
    };
  }
}
