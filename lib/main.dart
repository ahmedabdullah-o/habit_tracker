import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/app/shell/app_shell.dart';
import 'package:habit_tracker/core/services/notifications/notifications_provider.dart';

final _router = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => AppShell())],
);

void main() {
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);
    notifications.init();
    return MaterialApp.router(routerConfig: _router);
  }
}
