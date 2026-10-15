import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../logic/currency.dart';
import '../logic/numbers.dart';
import '../widgets/app_page.dart';

class ConverterResultScreen extends StatelessWidget {
  const ConverterResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final query = GoRouterState.of(context).uri.queryParameters;

    final result = convertCurrency(
      query['amount'],
      query['from'],
      query['to'],
    );

    return AppPage(
      title: result is CurrencySuccess
          ? 'Результат конвертации'
          : 'Ошибка конвертации',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (result is CurrencySuccess) ...[
            Text(
              '${query['amount']} ${query['from']} =',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              '${formatNumber(result.value)} ${query['to']}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
          if (result is CurrencyFailure)
            Text(
              result.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => context.go('/converter'),
            child: const Text('Вернуться к конвертеру'),
          ),
        ],
      ),
    );
  }
}
