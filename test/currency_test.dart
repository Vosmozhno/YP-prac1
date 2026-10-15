import 'package:flutter_test/flutter_test.dart';
import 'package:calc_web/logic/currency.dart';

void main() {
  test('Доллары переводятся в рубли', () {
    final result =
        convertCurrency('10', 'USD', 'RUB') as CurrencySuccess;

    expect(result.value, 900.0);
  });

  test('Доллары переводятся в евро через общий базовый курс', () {
    final result =
        convertCurrency('10', 'USD', 'EUR') as CurrencySuccess;

    expect(result.value, closeTo(9.0, 1e-9));
  });

  test('Одинаковые валюты сохраняют сумму', () {
    final result =
        convertCurrency('123.45', 'EUR', 'EUR') as CurrencySuccess;

    expect(result.value, closeTo(123.45, 1e-9));
  });

  test('Нулевая сумма допустима', () {
    final result =
        convertCurrency('0', 'USD', 'RUB') as CurrencySuccess;

    expect(result.value, 0.0);
  });

  test('Сумма с запятой поддерживается', () {
    final result =
        convertCurrency('12,5', 'RUB', 'CNY') as CurrencySuccess;

    expect(result.value, closeTo(1.0, 1e-9));
  });

  test('Нечисловая сумма возвращает ошибку', () {
    expect(
      convertCurrency('abc', 'USD', 'RUB'),
      isA<CurrencyFailure>(),
    );
  });

  test('Отрицательная сумма возвращает ошибку', () {
    expect(
      convertCurrency('-10', 'USD', 'RUB'),
      isA<CurrencyFailure>(),
    );
  });

  test('Неизвестная валюта возвращает ошибку', () {
    expect(
      convertCurrency('10', 'XXX', 'RUB'),
      isA<CurrencyFailure>(),
    );
    expect(
      convertCurrency('10', 'USD', 'XXX'),
      isA<CurrencyFailure>(),
    );
  });

  test('Отсутствующие параметры возвращают ошибку', () {
    expect(
      convertCurrency(null, 'USD', 'RUB'),
      isA<CurrencyFailure>(),
    );
    expect(
      convertCurrency('10', null, 'RUB'),
      isA<CurrencyFailure>(),
    );
    expect(
      convertCurrency('10', 'USD', null),
      isA<CurrencyFailure>(),
    );
  });

  test('NaN и Infinity не принимаются', () {
    expect(
      convertCurrency('NaN', 'USD', 'RUB'),
      isA<CurrencyFailure>(),
    );
    expect(
      convertCurrency('Infinity', 'USD', 'RUB'),
      isA<CurrencyFailure>(),
    );
  });

  test('Переполнение результата возвращает ошибку', () {
    expect(
      convertCurrency('1e308', 'USD', 'RUB'),
      isA<CurrencyFailure>(),
    );
  });
}
