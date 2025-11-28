import 'package:habit_tracker/core/enums/svg_icon_data_enums.dart';

extension SvgIconDataExtensions on SvgIconData{
  String get path => 'assets/icons/$name.svg';
}