import 'package:deciml_assignment/models/currency_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Globals {
  var box = Hive.box('Currencies');
  String? getSymbolByName(String currencyName) {
    List<Currency> currencies =
        List<Currency>.from(box.get('currencies') ?? []);

    Currency? currency = currencies.firstWhere(
      (currency) => currency.name?.toLowerCase() == currencyName.toLowerCase(),
      orElse: () => Currency(symbol: '', name: ''),
    );
    return currency.symbol;
  }

    String? getCodeByName(String currencyName) {
    List<Currency> currencies =
        List<Currency>.from(box.get('currencies') ?? []);

    Currency? currency = currencies.firstWhere(
      (currency) => currency.name?.toLowerCase() == currencyName.toLowerCase(),
      orElse: () => Currency(symbol: '', name: ''),
    );
    return currency.code;
  }


  static String getInitials(String fullName) {
  print(fullName);
  List<String> nameParts = fullName.split(' ');
  print(nameParts);
   if (nameParts.length >= 2&& nameParts[1].isNotEmpty) {
    // If there are at least two words, return the initials of both
    return '${nameParts[0][0]}${nameParts[1][0]}';
  } else if (nameParts.isNotEmpty && nameParts[0].isNotEmpty) {
    print(nameParts);
    // If there is only one word and it's not empty, return the initial of the single word
    return '${nameParts[0][0]}';
  } else {
    // Handle the case where the input string is empty or contains only whitespace
    return '';
  }
}


 String convertDate(String dateString) {
    // Parse the input date string
    DateTime date = DateTime.parse(dateString);

    // Format the date to month and day
    String formattedDate = '${_getAbbreviatedMonthName(date.month)} ${date.day}';

    return formattedDate;
  }

  String _getAbbreviatedMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}
