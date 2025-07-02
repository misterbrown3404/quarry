import 'package:Quarry/common/styles/spacing_style.dart';
import 'package:Quarry/common/widgets/appbar/appbar.dart';
import 'package:Quarry/features/shop/screens/customer/widgets/TAdd_Customer.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';


class AddCustomer extends StatelessWidget {
  const AddCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TAppBar(showBackArrow: true, title: Text('Add Customer')),
            Padding(
              padding: TSpacingStyle.paddingWithAppForHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //SizedBox(height: TSizes.spaceBtwSections),

                  /// Add Customer form
                  TaddCustomer(dark: dark),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
