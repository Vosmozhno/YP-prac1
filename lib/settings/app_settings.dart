import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../logic/currency.dart';

final appSettings = AppSettings();

class AppSettings extends ChangeNotifier {
  late final _preferences = SharedPreferencesAsync();

  bool _isDark = false;
  String _fromCurrency = 'RUB';
  String _toCurrency = 'USD';

  ThemeMode get themeMode =>
      _isDark ? ThemeMode.dark : ThemeMode.light;

  String get fromCurrency => _fromCurrency;
  String get toCurrency => _toCurrency;

  Future<void> load() async {
    _isDark = await _preferences.getBool('darkTheme') ?? false;

    final pair = await _preferences.getStringList('currencyPair');

    if (pair != null &&
        pair.length == 2 &&
        currencyRates.containsKey(pair[0]) &&
        currencyRates.containsKey(pair[1])) {
      _fromCurrency = pair[0];
      _toCurrency = pair[1];
    }
  }

  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    notifyListeners();

    await _preferences.setBool('darkTheme', _isDark);
  }

  Future<void> saveCurrencyPair(String from, String to) async {
    _fromCurrency = from;
    _toCurrency = to;

    await _preferences.setStringList('currencyPair', [from, to]);
  }
}
