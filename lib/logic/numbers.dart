double? parseNumber(String? raw) {
  final text = raw?.trim().replaceAll(',', '.') ?? '';
  final value = double.tryParse(text);

  if (value == null || !value.isFinite) {
    return null;
  }

  return value;
}

String formatNumber(double value) {
  final fixed = value.toStringAsFixed(6);

  if (fixed.contains('e')) {
    return fixed;
  }

  final text = fixed
      .replaceFirst(RegExp(r'0+$'), '')
      .replaceFirst(RegExp(r'\.$'), '');

  return text == '-0' ? '0' : text;
}
