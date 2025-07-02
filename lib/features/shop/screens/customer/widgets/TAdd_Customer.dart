import 'package:Quarry/features/shop/screens/customer/controller/customer_controller.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:Quarry/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TaddCustomer extends StatelessWidget {
  const TaddCustomer({super.key, required this.dark});
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
      return Form(
      key: controller.customerFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.nameController,
            validator: (value) => TValidator.validateEmptyText('Name', value),
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.user),
              labelText: TTexts.customerName,
            ),
          ),
          SizedBox(height: TSizes.spaceBtwInputFields),

          /// Price Per Unit
          TextFormField(
            controller: controller.phoneController,
            validator: (value) =>
                TValidator.validateEmptyText('Number', value),
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.mobile),
              labelText: TTexts.phoneNo,
            ),
          ),
          SizedBox(height: TSizes.spaceBtwInputFields),

          /// Price Per Unit
          TextFormField(
            controller: controller.priceController,
            validator: (value) =>
                TValidator.validateEmptyText('Price', value),
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.money),
              labelText: TTexts.price,
            ),
          ),
          /// Add Sale Button
          SizedBox(height: TSizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                controller.submitCustomerForm();
                // Handle form submission
              },
              child: const Text('Add Customer'),
            ),
          ),

        ],
      ),
    );
  }
}

