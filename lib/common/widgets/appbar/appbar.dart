import 'package:Quarry/utils/constants/colors.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.actions,
    this.leadingOnPressed,
    this.leadingIcon,
  });

  final Widget? title;
  final IconData? leadingIcon;
  final bool showBackArrow;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
          color: darkMode ? TColors.white: TColors.black,
                onPressed: () => Get.back(),
                icon: Icon(Iconsax.arrow_left),
              )
            : leadingIcon != null
            ? IconButton(
          color: darkMode ? TColors.white : TColors.black ,
                onPressed: leadingOnPressed,
                icon: Icon(Iconsax.arrow_left),
              )
            : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
