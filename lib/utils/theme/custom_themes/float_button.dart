import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Floating Action Button Themes -- */
class TFloatingActionButtonTheme {
  TFloatingActionButtonTheme._(); // Prevent instantiation

  /* -- Light Theme -- */
  static final lightFABTheme = FloatingActionButtonThemeData(
    backgroundColor: TColors.primary,
    foregroundColor: TColors.light,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TSizes.buttonRadius),
    ),
  );

  /* -- Dark Theme -- */
  static final darkFABTheme = FloatingActionButtonThemeData(
    backgroundColor: TColors.primary,
    foregroundColor: TColors.light,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TSizes.buttonRadius),
    ),
  );
}
