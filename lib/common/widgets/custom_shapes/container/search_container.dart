import 'package:Quarry/utils/constants/colors.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:Quarry/utils/device/device_utility.dart';
import 'package:Quarry/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.onChanged,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.hintText = TTexts.search,
  });

  final ValueChanged<String> onChanged;
  final IconData icon;
  final bool showBackground, showBorder;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Container(
        width: TDeviceUtils.getScreenWidth(context),
        decoration: BoxDecoration(
          color: showBackground
              ? (dark ? TColors.dark : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          border: showBorder ? Border.all(color: TColors.info) : null,
        ),
        child: TextField(
          onChanged: onChanged,
          style: TextStyle(
            color: dark ? TColors.white : TColors.black,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            border: InputBorder.none,
            prefixIcon: Icon(icon, color: TColors.info),
            hintText: hintText,
            hintStyle: TextStyle(
              color: dark ? TColors.white.withOpacity(0.6) : TColors.black.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }
}
