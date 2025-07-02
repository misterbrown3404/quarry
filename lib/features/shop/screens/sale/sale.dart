import 'package:Quarry/common/styles/spacing_style.dart';
import 'package:Quarry/common/widgets/appbar/appbar.dart';
import 'package:Quarry/features/shop/screens/sale/widget/TsaleForm.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class Sale extends StatelessWidget {
  const Sale({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: TSizes.spaceBtwSections),
            TAppBar(showBackArrow: true, title: Text('Add Sale')),
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Quantity
                  TSaleForm(dark: dark),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
