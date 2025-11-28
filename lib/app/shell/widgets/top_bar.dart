import 'package:flutter/material.dart';
import 'package:habit_tracker/core/enums/svg_icon_data_enums.dart';
import 'package:habit_tracker/core/style/colors.dart' as app;
import 'package:habit_tracker/core/style/fonts.dart';
import 'package:habit_tracker/core/style/icons.dart';

final _title = {'/home': 'TODAY', '/habits': "HABITS"};

class TopBar extends StatelessWidget {
  final String currentPath;
  const TopBar(this.currentPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: app.Colors.background,
      height: 48.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: SvgIcon(
                  SvgIconData.user,
                  width: 32,
                  height: 32,
                  color: app.Colors.textSecondary,
                ),
              ),
              SizedBox(width: 12),
              Text(_title[currentPath] ?? '', style: Fonts.titleTextStyle),
            ],
          ),
          _ProgressBar(40),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double completionRate;
  const _ProgressBar(this.completionRate);

  @override
  Widget build(BuildContext context) {
    if (completionRate > 100 || completionRate < 0) {
      throw Exception(
        'completion rate error: CompletionRate value must be between 0 and 100',
      );
    }
    return Container(
      width: 128,
      height: 16,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        alignment: AlignmentGeometry.centerLeft,
        children: [
          Container(
            width: completionRate * 128 / 100,
            height: 16,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(6),
              color: app.Colors.primary50,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: 128,
            height: 16,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.5,
                color: app.Colors.text,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
