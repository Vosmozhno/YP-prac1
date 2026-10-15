import 'numbers.dart';

sealed class CalcResult {
  const CalcResult();
}

final class CalcSuccess extends CalcResult {
  const CalcSuccess(this.value);

  final double value;
}

final class CalcFailure extends CalcResult {
  const CalcFailure(this.message);

  final String message;
}

CalcResult calculate(
  String? rawA,
  String? rawOp,
  String? rawB,
) {
  if (rawA == null || rawOp == null || rawB == null) {
    return const CalcFailure(
      'В адресе отсутствует обязательный параметр: a, op или b.',
    );
  }

  final a = parseNumber(rawA);
  final b = parseNumber(rawB);

  if (a == null || b == null) {
    return const CalcFailure(
      'В адресе переданы некорректные числа.',
    );
  }

  final result = switch (rawOp) {
    '+' => CalcSuccess(a + b),
    '-' => CalcSuccess(a - b),
    '*' => CalcSuccess(a * b),
    '/' => b == 0
        ? const CalcFailure('Деление на ноль невозможно.')
        : CalcSuccess(a / b),
    _ => const CalcFailure('Неизвестная операция.'),
  };

  if (result is CalcSuccess && !result.value.isFinite) {
    return const CalcFailure(
      'Результат слишком велик для вычисления.',
    );
  }

  return result;
}
