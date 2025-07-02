import 'package:Quarry/features/shop/screens/sale/controller/sales_controller.dart';
import 'package:Quarry/features/shop/screens/sale/widget/sale_model.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:Quarry/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class TSaleForm extends StatelessWidget {
  const TSaleForm({super.key, required this.dark});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SalesController());
    return Obx(() {
      final customerNames = controller.customerList
          .map((c) => c.customerName)
          .toList();

      return Form(
        key: controller.saleFormKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: controller.selectedCustomer,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select Customer',
              ),
              items: customerNames.map((name) {
                return DropdownMenuItem(
                  value: name,
                  child: Text(name),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedCustomer = value!;
                controller.updateCustomerPrice();
              },
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            DropdownButtonFormField<String>(
              value: controller.selectedMaterial,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select Material',
              ),
              items: materials
                  .map((material) =>
                  DropdownMenuItem(
                    value: material,
                    child: Text(material),
                  ))
                  .toList(),
              onChanged: (value) {
                controller.selectedMaterial = value!;
              },
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            TextFormField(
              controller: controller.tonsController,
              validator: (value) => TValidator.validateEmptyText('Tons', value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.truck),
                labelText: TTexts.tons,
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            /// Price Per Unit
            TextFormField(
              controller: controller.priceController,
              validator: (value) =>
                  TValidator.validateEmptyText('Price', value),
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.signpost),
                labelText: TTexts.price,
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            /// Date Picker Field
            TextField(
              controller: controller.dateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Date',
                prefixIcon: Icon(Iconsax.calendar),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2025),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  controller.dateController.text =
                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                }
              },
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            TextFormField(
              controller: controller.transportController,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.truck),
                labelText: 'Transport price',
              ),
            ),

            /// Add Sale Button
            SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.submitSaleForm();
                  // Handle form submission
                },
                child: const Text('Add Sale'),
              ),
            ),
          ],
        ),
      );
    }
    );
  }
}
