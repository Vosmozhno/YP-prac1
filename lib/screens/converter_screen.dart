import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../logic/currency.dart';
import '../logic/numbers.dart';
import '../settings/app_settings.dart';
import '../widgets/app_page.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  late String _fromCurrency;
  late String _toCurrency;

  @override
  void initState() {
    super.initState();
    _fromCurrency = appSettings.fromCurrency;
    _toCurrency = appSettings.toCurrency;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String? _amountValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите сумму';
    }

    final amount = parseNumber(value);

    if (amount == null) {
      return 'Введите корректное конечное число';
    }

    if (amount < 0) {
      return 'Сумма не может быть отрицательной';
    }

    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final uri = Uri(
      path: '/converter/result',
      queryParameters: {
        'amount': _amountController.text.trim().replaceAll(',', '.'),
        'from': _fromCurrency,
        'to': _toCurrency,
      },
    );

    context.go(uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Конвертер валют',
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _fromCurrency,
              decoration: const InputDecoration(
                labelText: 'Из какой валюты',
                border: OutlineInputBorder(),
              ),
              items: currencyRates.keys
                  .map(
                    (code) => DropdownMenuItem(
                      value: code,
                      child: Text(code),
                    ),
                  )
                  .toList(),
              onChanged: (value) async {
                if (value == null) return;

                setState(() => _fromCurrency = value);

                await appSettings.saveCurrencyPair(
                  _fromCurrency,
                  _toCurrency,
                );
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _toCurrency,
              decoration: const InputDecoration(
                labelText: 'В какую валюту',
                border: OutlineInputBorder(),
              ),
              items: currencyRates.keys
                  .map(
                    (code) => DropdownMenuItem(
                      value: code,
                      child: Text(code),
                    ),
                  )
                  .toList(),
              onChanged: (value) async {
                if (value == null) return;

                setState(() => _toCurrency = value);

                await appSettings.saveCurrencyPair(
                  _fromCurrency,
                  _toCurrency,
                );
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              decoration: const InputDecoration(
                labelText: 'Сумма',
                border: OutlineInputBorder(),
              ),
              validator: _amountValidator,
            ),
            const SizedBox(height: 16),
            const Text(
              'Используются учебные фиксированные курсы.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _submit,
              child: const Text('Конвертировать'),
            ),
          ],
        ),
      ),
    );
  }
}
