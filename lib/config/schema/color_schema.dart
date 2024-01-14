import 'package:flutter/material.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';

class AppTheme {
  static final ThemeData appThemeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.green,
      background: AppColor.background,
      onBackground: AppColor.background,
    ),
  );
}
