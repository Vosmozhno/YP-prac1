import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../settings/app_settings.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.title,
    required this.child,
    this.showHome = true,
  });

  final String title;
  final Widget child;
  final bool showHome;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: showHome
            ? IconButton(
                tooltip: 'На главную',
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.home_outlined),
              )
            : null,
        title: Text(title),
        actions: [
          IconButton(
            tooltip: isDark
                ? 'Включить светлую тему'
                : 'Включить тёмную тему',
            onPressed: appSettings.toggleTheme,
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: SizedBox(
                width: double.infinity,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
