import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../logic/calculator.dart';
import '../logic/numbers.dart';
import '../widgets/app_page.dart';

class CalculatorResultScreen extends StatelessWidget {
  const CalculatorResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final query = GoRouterState.of(context).uri.queryParameters;

    final result = calculate(
      query['a'],
      query['op'],
      query['b'],
    );

    return AppPage(
      title: result is CalcSuccess
          ? 'Результат вычисления'
          : 'Ошибка вычисления',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (result is CalcSuccess) ...[
            Text(
              '${query['a']} ${query['op']} ${query['b']} =',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              formatNumber(result.value),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
          if (result is CalcFailure)
            Text(
              result.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => context.go('/calculator'),
            child: const Text('Вернуться к калькулятору'),
          ),
        ],
      ),
    );
  }
}
