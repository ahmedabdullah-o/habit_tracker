import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/entities/habit_data.dart';
import 'package:habit_tracker/core/enums/svg_icon_data_enums.dart';
import 'package:habit_tracker/core/extensions/habit_data_extensions.dart';
import 'package:habit_tracker/core/style/colors.dart' as app;
import 'package:habit_tracker/core/style/fonts.dart';
import 'package:habit_tracker/core/style/icons.dart';
import 'package:logging/logging.dart';
import 'package:smooth_corner/smooth_corner.dart';

class HabitWidget extends ConsumerWidget {
  final String name;
  final String caption;
  final String trailingText;
  final Color colorCode;
  final SvgIconData svgIconData;

  /// whether the habit is checked or not initially.
  /// double is used instead of bool for scalability, we might actually need to
  /// add fuzzy logic later.
  final double? initialState;

  const HabitWidget(
    this.name,
    this.caption,
    this.trailingText,
    this.colorCode,
    this.svgIconData,
    this.initialState, {
    super.key,
  });

  static final Logger _logger = Logger('HabitTracker.Widgets.HabitWidget');

  static Future<HabitWidget> fromHabitData(
    HabitData habitData,
    database,
  ) async {
    _logger.info('fromHabitData: Starting creation from HabitData');
    _logger.fine('fromHabitData: HabitData - name: ${habitData.name.value}');

    try {
      final categoryData = await habitData.categoryData(database);
      _logger.fine(
        'fromHabitData: Category data retrieved - color: ${categoryData?.color.value}',
      );

      final completionState = await habitData.completionState(database);
      _logger.fine('fromHabitData: Completion state: $completionState');

      final reminderHour = habitData.reminderTime.value.hour.toString().padLeft(
        2,
        '0',
      );
      final reminderMinute = habitData.reminderTime.value.minute
          .toString()
          .padLeft(2, '0');
      final reminderTimeFormatted = "$reminderHour:$reminderMinute";

      _logger.info(
        'fromHabitData: Successfully created HabitWidget - name: ${habitData.name.value}, reminder: $reminderTimeFormatted, completion: $completionState',
      );

      return HabitWidget(
        habitData.name.value,
        // NOTE: should add the priority/order next to the category name here. Still not implemented in the database, though.
        "habit • 0",
        reminderTimeFormatted,
        categoryData?.color.value ?? app.Colors.primary,
        SvgIconData.loop,
        completionState,
      );
    } catch (e, stackTrace) {
      _logger.severe(
        'fromHabitData: Error creating HabitWidget',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _logger.fine(
      'build: Building HabitWidget - name: $name, initialState: $initialState',
    );

    try {
      return Container(
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: app.Colors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        foregroundDecoration: BoxDecoration(
          border: Border.symmetric(
            vertical: BorderSide(
              color: colorCode,
              strokeAlign: BorderSide.strokeAlignInside,
              width: 4,
            ),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: [
            // leading
            Row(
              spacing: 8,
              children: [
                // icon
                _HabitWidgetIcon(svgIconData),
                // text
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Fonts.habitWidgetTitle),
                    Text(caption, style: Fonts.habitWidgetCaption),
                  ],
                ),
              ],
            ),
            // Trailing
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              width: 112,
              height: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      trailingText,
                      style: Fonts.habitWidgetTrailingText,
                    ),
                  ),
                  _CheckBox(initialState, name),
                ],
              ),
            ),
          ],
        ),
      );
    } catch (e, stackTrace) {
      _logger.severe(
        'build: Error building HabitWidget for habit: $name',
        e,
        stackTrace,
      );
      rethrow;
    }
  }
}

class _HabitWidgetIcon extends StatelessWidget {
  final SvgIconData svgIconData;

  static final Logger _logger = Logger(
    'HabitTracker.Widgets.HabitWidget._HabitWidgetIcon',
  );

  const _HabitWidgetIcon(this.svgIconData);

  @override
  Widget build(BuildContext context) {
    _logger.finer('build: Building icon with svgIconData: $svgIconData');

    return Container(
      width: 80,
      height: double.infinity,
      color: app.Colors.text,
      child: SvgIcon(
        svgIconData,
        width: 40,
        height: 40,
        color: app.Colors.surface,
      ),
    );
  }
}

class _CheckBox extends StatefulWidget {
  final double? initialState;
  final String habitName;

  const _CheckBox(this.initialState, this.habitName);

  @override
  State<_CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<_CheckBox> {
  static final Logger _logger = Logger(
    'HabitTracker.Widgets.HabitWidget._CheckBox',
  );
  late bool checked;

  @override
  void initState() {
    super.initState();
    checked = widget.initialState != null && widget.initialState! > 0;
    _logger.fine(
      'initState: Checkbox initialized for habit "${widget.habitName}" - initialState: ${widget.initialState}, checked: $checked',
    );
  }

  @override
  void didUpdateWidget(_CheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialState != widget.initialState) {
      checked = widget.initialState != null && widget.initialState! > 0;
      _logger.fine(
        'didUpdateWidget: Checkbox state updated for habit "${widget.habitName}" - old: ${oldWidget.initialState}, new: ${widget.initialState}, checked: $checked',
      );
    }
  }

  void onTap() {
    setState(() {
      // NOTE: Forcing binary logic temporarily
      checked ^= true;
      _logger.info(
        'onTap: Checkbox toggled for habit "${widget.habitName}" - new state: $checked',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _logger.finer(
      'build: Building checkbox for habit "${widget.habitName}" - checked: $checked',
    );

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 24,
        height: 24,
        child: Stack(
          children: [
            Center(
              child: SmoothContainer(
                width: 24,
                height: 24,
                side: BorderSide(
                  color: checked ? Colors.transparent : app.Colors.text,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
                color: checked ? app.Colors.success : Colors.transparent,
              ),
            ),
            Center(
              child: checked
                  ? SvgIcon(
                      SvgIconData.checkmark,
                      width: 16.3,
                      height: 12.03,
                      color: app.Colors.surface,
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _logger.finer(
      'dispose: Disposing checkbox for habit "${widget.habitName}"',
    );
    super.dispose();
  }
}
