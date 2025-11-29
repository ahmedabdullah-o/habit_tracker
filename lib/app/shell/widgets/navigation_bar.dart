import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/core/enums/svg_icon_data_enums.dart';
import 'package:habit_tracker/core/style/colors.dart' as app;
import 'package:habit_tracker/core/style/fonts.dart';
import 'package:habit_tracker/core/style/icons.dart';

class NavigationBar extends StatelessWidget {
  final String currentPath;
  const NavigationBar({super.key, required this.currentPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: app.Colors.foreground),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _NavItem(
            label: 'today',
            iconData: SvgIconData.checklist,
            showLabel: true,
            active: currentPath == '/home',
            onTap: () => context.go('/home'),
          ),
          _AddButton(),
          _NavItem(
            label: 'habits',
            iconData: SvgIconData.loop,
            showLabel: true,
            active: currentPath == '/habits',
            onTap: () => context.go('/habits'),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final SvgIconData iconData;
  final bool showLabel;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.iconData,
    required this.showLabel,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          active
              ? Container(
                  width: 60,
                  height: 32,
                  decoration: BoxDecoration(
                    color: app.Colors.primary50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                )
              : SizedBox(width: 60, height: 32),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 60,
                height: 32,
                child: SvgIcon(
                  iconData,
                  width: 30,
                  height: 30,
                  color: app.Colors.text,
                ),
              ),
              Text(label, style: Fonts.navigationBarItemTextStyle(active)),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            width: 80,
            height: 48,
            decoration: BoxDecoration(
              color: app.Colors.primary50,
              border: BoxBorder.all(
                width: 2,
                color: app.Colors.primary50,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          SizedBox(
            width: 80,
            height: 48,
            child: Center(
              child: SvgIcon(
                SvgIconData.add,
                width: 28,
                height: 28,
                color: app.Colors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
