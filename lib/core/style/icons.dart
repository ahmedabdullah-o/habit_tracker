import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_tracker/core/enums/svg_icon_data_enums.dart';
import 'package:habit_tracker/core/extensions/svg_icon_data_extensions.dart';

class SvgIcon {
  SvgIconData svgIconData;
  double width;
  double height;
  Color color;
  SvgIcon(
    this.svgIconData, {
    required this.width,
    required this.height,
    required this.color,
  });

  SvgPicture get draw => SvgPicture.asset(
    svgIconData.path,
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  );
}
