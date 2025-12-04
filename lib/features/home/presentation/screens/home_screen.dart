import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/db/database_provider.dart';
import 'package:habit_tracker/core/db/idatabase.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';
import 'package:habit_tracker/core/style/colors.dart' as app;
import 'package:habit_tracker/features/home/presentation/screens/home_screen_empty_state.dart';
import 'package:habit_tracker/features/home/presentation/widgets/habit_widget.dart';
import 'package:logging/logging.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static final Logger _logger = Logger('HabitTracker.Screens.HomeScreen');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _logger.info('build: Building HomeScreen');

    Future<List<HabitWidget>> mapToWidgets(List<HabitData> habitsToday) async {
      _logger.fine('mapToWidgets: Starting mapping of ${habitsToday.length} habits to widgets');
      
      try {
        final database = await ref.read(databaseProvider(false).future);
        _logger.fine('mapToWidgets: Database instance obtained');
        
        final widgets = await Future.wait(
          habitsToday.map((item) async {
            _logger.finer('mapToWidgets: Processing habit - name: ${item.name.value}, id: ${item.id.value}');
            
            try {
              final widget = await HabitWidget.fromHabitData(item, database);
              _logger.finer('mapToWidgets: Successfully created widget for habit: ${item.name.value}');
              return widget;
            } catch (e, stackTrace) {
              _logger.severe('mapToWidgets: Error creating widget for habit: ${item.name.value}', e, stackTrace);
              rethrow;
            }
          }),
        );
        
        _logger.info('mapToWidgets: Successfully mapped ${widgets.length} habits to widgets');
        return widgets;
      } catch (e, stackTrace) {
        _logger.severe('mapToWidgets: Fatal error during widget mapping', e, stackTrace);
        rethrow;
      }
    }

    return FutureBuilder<Idatabase>(
      future: ref.read(databaseProvider(false).future),
      builder: (context, snapshot) {
        _logger.fine('build: Database FutureBuilder state: ${snapshot.connectionState}');
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          _logger.fine('build: Waiting for database connection');
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          _logger.severe('build: Database connection error', snapshot.error, snapshot.stackTrace);
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final database = snapshot.data!;
        _logger.info('build: Database connection established successfully');

        return FutureBuilder<List<HabitData>?>(
          future: database.getTodayHabits(),
          builder: (context, habitsSnapshot) {
            _logger.fine('build: Habits FutureBuilder state: ${habitsSnapshot.connectionState}');
            
            if (habitsSnapshot.connectionState == ConnectionState.waiting) {
              _logger.fine('build: Waiting for today\'s habits data');
              return const Center(child: CircularProgressIndicator());
            }

            if (habitsSnapshot.hasError) {
              _logger.severe('build: Error fetching today\'s habits', habitsSnapshot.error, habitsSnapshot.stackTrace);
              return Center(child: Text('Error: ${habitsSnapshot.error}'));
            }

            final habitsToday = habitsSnapshot.data ??
                [
                  HabitData(
                    id: Value(1),
                    name: Value('read'),
                    desc: Value('habit desc'),
                    categoryId: Value(0),
                    startDatetime: Value(DateTime.now()),
                    endDatetime: Value(DateTime.now().add(Duration(days: 1))),
                    reminderTime: Value(TimeOfDay.now()),
                  ),
                ];

            if (habitsSnapshot.data == null) {
              _logger.warning('build: No habits data returned, using fallback dummy habit');
            } else {
              _logger.info('build: Retrieved ${habitsToday.length} habits for today');
              for (var habit in habitsToday) {
                _logger.fine('build: Habit - id: ${habit.id.value}, name: ${habit.name.value}');
              }
            }

            if (habitsToday.isEmpty) {
              _logger.info('build: No habits for today, showing empty state');
              return const HomeScreenEmptyState();
            }

            return FutureBuilder<List<HabitWidget>>(
              future: mapToWidgets(habitsToday),
              builder: (context, widgetsSnapshot) {
                _logger.fine('build: Widgets FutureBuilder state: ${widgetsSnapshot.connectionState}');
                
                if (widgetsSnapshot.connectionState == ConnectionState.waiting) {
                  _logger.fine('build: Waiting for habit widgets to be created');
                  return const Center(child: CircularProgressIndicator());
                }

                if (widgetsSnapshot.hasError) {
                  _logger.severe('build: Error creating habit widgets', widgetsSnapshot.error, widgetsSnapshot.stackTrace);
                  return Center(child: Text('Error: ${widgetsSnapshot.error}'));
                }

                final habitsWidgets = widgetsSnapshot.data!;
                _logger.info('build: Successfully created ${habitsWidgets.length} habit widgets, rendering ListView');

                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: app.Colors.background,
                  padding: EdgeInsets.all(20),
                  child: ListView(children: habitsWidgets),
                );
              },
            );
          },
        );
      },
    );
  }
}