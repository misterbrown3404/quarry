import 'package:Quarry/common/widgets/appbar/appbar.dart';
import 'package:Quarry/features/shop/screens/profile/profile.dart';
import 'package:Quarry/utils/constants/colors.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:Quarry/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key, required this.title, required this.name,
  });
  final String title;
  final String name;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TAppBar(
      title: Row(
        children: [
          Text(
          title,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.apply(color: dark ? TColors.white : TColors.black),
          ),
          Text(
            name,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.apply(color: dark ? TColors.info : TColors.info),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           // IconButton(onPressed: () {}, icon: Icon(Iconsax.setting),color: dark ? TColors.white : TColors.info),
            IconButton(onPressed: () => Get.to(()=>ProfileScreen()),
             icon: Icon(Iconsax.user),color: dark ? TColors.white : TColors.info,),
          ],
        )
      ],
    );
  }
}
