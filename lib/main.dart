import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/app/shell/app_shell.dart';
import 'package:habit_tracker/core/services/notifications/notifications_provider.dart';
import 'package:habit_tracker/core/style/colors.dart' as app;
import 'package:habit_tracker/features/habits/presentation/habits_screen.dart';
import 'package:habit_tracker/features/home/presentation/screens/home_screen.dart';
import 'package:logging/logging.dart';

final _router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
        GoRoute(path: '/habits', builder: (context, state) => HabitsScreen()),
      ],
    ),
  ],
  initialLocation: '/home',
);

void _loggerConfig() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      debugPrint(
        '${record.level.name}: ${record.loggerName}: ${record.message}',
      );
      if (record.error != null) {
        debugPrint('${record.error}\n${record.stackTrace}');
      }
    }
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: app.Colors.foreground,
      systemNavigationBarDividerColor: app.Colors.foreground,
      statusBarColor: app.Colors.background,
    ),
  );

  _loggerConfig();

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);
    notifications.init();
    return SafeArea(
      child: MaterialApp.router(
        color: app.Colors.background,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
