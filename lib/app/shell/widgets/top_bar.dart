import 'package:flutter/material.dart';
import 'package:habit_tracker/core/style/colors.dart' as app;

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: app.Colors.background,
      height: 40.0,
      width: double.infinity,
    );
  }
}
