import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/features/habits/presentation/habits_screen.dart';
import 'package:habit_tracker/features/home/presentation/screens/home_screen.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  final _screens = [HomeScreen(), HabitsScreen()];
  final _navBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Today'),
    BottomNavigationBarItem(icon: Icon(Icons.repeat), label: 'Habits'),
  ];
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    if (index == _currentIndex) return; // prevent unnecessary rebuild
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        items: _navBarItems,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
