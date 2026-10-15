import 'package:flutter_test/flutter_test.dart';
import 'package:calc_web/logic/calculator.dart';
import 'package:calc_web/logic/numbers.dart';

void main() {
  test('Сложение', () {
    final result = calculate('2', '+', '3') as CalcSuccess;
    expect(result.value, 5.0);
  });

  test('Вычитание', () {
    final result = calculate('7', '-', '4') as CalcSuccess;
    expect(result.value, 3.0);
  });

  test('Умножение', () {
    final result = calculate('6', '*', '7') as CalcSuccess;
    expect(result.value, 42.0);
  });

  test('Деление', () {
    final result = calculate('10', '/', '4') as CalcSuccess;
    expect(result.value, 2.5);
  });

  test('Дробные числа с запятой', () {
    final result = calculate('1,5', '+', '2,5') as CalcSuccess;
    expect(result.value, 4.0);
  });

  test('Деление на ноль возвращает ошибку', () {
    expect(calculate('10', '/', '0'), isA<CalcFailure>());
  });

  test('Нечисловой ввод возвращает ошибку', () {
    expect(calculate('abc', '+', '2'), isA<CalcFailure>());
  });

  test('Отсутствие обязательных параметров возвращает ошибку', () {
    expect(calculate(null, '+', '2'), isA<CalcFailure>());
    expect(calculate('1', null, '2'), isA<CalcFailure>());
    expect(calculate('1', '+', null), isA<CalcFailure>());
  });

  test('Неизвестная операция возвращает ошибку', () {
    expect(calculate('2', '^', '3'), isA<CalcFailure>());
  });

  test('NaN и Infinity не принимаются', () {
    expect(calculate('NaN', '+', '2'), isA<CalcFailure>());
    expect(calculate('Infinity', '+', '2'), isA<CalcFailure>());
  });

  test('Переполнение результата возвращает ошибку', () {
    expect(
      calculate('1e308', '*', '1e308'),
      isA<CalcFailure>(),
    );
  });

  test('Результат округляется до шести знаков', () {
    expect(formatNumber(10 / 3), '3.333333');
  });

  test('У целого результата нет лишних нулей', () {
    expect(formatNumber(5), '5');
  });

  test('Форматирование сохраняет степень большого числа', () {
    expect(formatNumber(1e30), '1e+30');
  });
}
