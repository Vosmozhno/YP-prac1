import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app_page.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    super.key,
    required this.location,
  });

  final String location;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Страница не найдена',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '404',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Не удалось найти страницу:\n$location',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => context.go('/'),
            child: const Text('Вернуться на главную'),
          ),
        ],
      ),
    );
  }
}
