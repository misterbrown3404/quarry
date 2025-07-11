import 'package:Quarry/utils/theme/custom_themes/appbar_theme.dart';
import 'package:Quarry/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:Quarry/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:Quarry/utils/theme/custom_themes/chip_theme.dart';
import 'package:Quarry/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:Quarry/utils/theme/custom_themes/float_button.dart';
import 'package:Quarry/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:Quarry/utils/theme/custom_themes/text_field_theme.dart';
import 'package:Quarry/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'custom_themes/date_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'PlusJakartaSans',
    disabledColor: TColors.grey,
    brightness: Brightness.light,
    primaryColor: TColors.primary,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: TColors.white,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    floatingActionButtonTheme: TFloatingActionButtonTheme.lightFABTheme,
    datePickerTheme: TDatePickerTheme.light
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: TColors.grey,
    brightness: Brightness.dark,
    primaryColor: TColors.primary,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: TColors.black,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    floatingActionButtonTheme: TFloatingActionButtonTheme.darkFABTheme,
    datePickerTheme: TDatePickerTheme.dark
  );
}
