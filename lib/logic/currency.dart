import 'numbers.dart';

const currencyRates = <String, double>{
  'RUB': 1,
  'USD': 90,
  'EUR': 100,
  'GBP': 120,
  'CNY': 12.5,
};

sealed class CurrencyResult {
  const CurrencyResult();
}

final class CurrencySuccess extends CurrencyResult {
  const CurrencySuccess(this.value);

  final double value;
}

final class CurrencyFailure extends CurrencyResult {
  const CurrencyFailure(this.message);

  final String message;
}

CurrencyResult convertCurrency(
  String? rawAmount,
  String? rawFrom,
  String? rawTo,
) {
  if (rawAmount == null || rawFrom == null || rawTo == null) {
    return const CurrencyFailure(
      'В адресе отсутствует обязательный параметр: amount, from или to.',
    );
  }

  final amount = parseNumber(rawAmount);

  if (amount == null) {
    return const CurrencyFailure('В адресе передана некорректная сумма.');
  }

  if (amount < 0) {
    return const CurrencyFailure('Сумма не может быть отрицательной.');
  }

  final fromRate = currencyRates[rawFrom];
  final toRate = currencyRates[rawTo];

  if (fromRate == null || toRate == null) {
    return const CurrencyFailure('Указана неизвестная валюта.');
  }

  final value = amount * (fromRate / toRate);

  if (!value.isFinite) {
    return const CurrencyFailure(
      'Результат слишком велик для вычисления.',
    );
  }

  return CurrencySuccess(value);
}
