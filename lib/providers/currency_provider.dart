import 'package:flutter/foundation.dart';

class CurrencyProvider with ChangeNotifier {
  String _selectedCurrency = 'COP';

  String get selectedCurrency => _selectedCurrency;

  void setSelectedCurrency(String currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  List<String> get availableCurrencies => ['COP', 'USD', 'EUR', 'GBP'];
}