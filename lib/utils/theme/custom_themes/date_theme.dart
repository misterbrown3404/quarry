import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class TDatePickerTheme {
  TDatePickerTheme._(); // Private constructor

  static final light = DatePickerThemeData(
    backgroundColor: TColors.light,
    headerBackgroundColor: TColors.light,
    dayForegroundColor: WidgetStateProperty.all(TColors.dark),
    yearForegroundColor: WidgetStateProperty.all(TColors.dark),
    todayForegroundColor: WidgetStateProperty.all(TColors.primary),
    todayBackgroundColor: WidgetStateProperty.all(TColors.primary.withOpacity(0.1)),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
    ),
  );

  static final dark = DatePickerThemeData(
    backgroundColor: TColors.dark,
    headerBackgroundColor: TColors.dark,
    dayForegroundColor: WidgetStateProperty.all(TColors.light),
    yearForegroundColor: WidgetStateProperty.all(TColors.light),
    todayForegroundColor: WidgetStateProperty.all(TColors.primary),
    todayBackgroundColor: WidgetStateProperty.all(TColors.primary.withOpacity(0.2)),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
    ),
  );
}
