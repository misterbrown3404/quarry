import 'package:Quarry/common/styles/spacing_style.dart';
import 'package:Quarry/common/widgets/login_signup/TloginHeader.dart';
import 'package:Quarry/features/shop/screens/sale/widget/sale_model.dart';
import 'package:Quarry/features/shop/screens/transaction/controller/transaction_contoller.dart';
import 'package:Quarry/features/shop/screens/transaction/widgets/sales_card.dart';
import 'package:Quarry/utils/constants/colors.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});


  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final controller = Get.put(TransactionController());

  @override
  void dispose(){
    controller.clearFilters();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Padding(
        padding: TSpacingStyle.paddingWithAppForHeight,
        child: Column(
          children: [
            // App Bar
            Center(
              child: TLoginHeader(
                title: 'Transactions',
                subtitle: 'View your transactions',
              ),
            ),
            SizedBox(height: TSizes.spaceBtwSections),

            // Filters Row
            Obx(() {
              final customerNames = controller.customerList
                  .map((c) => c.customerName)
                  .toList();
              if (controller.customerList.isEmpty) {
                return const Text('No Customer Found');
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// Customer Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: TColors.info),
                    ),
                    child: DropdownButton<String>(
                      value: controller.selectedCustomer.value.isEmpty
                          ? null
                          : controller.selectedCustomer.value,
                      hint: const Text('Customer'),
                      onChanged: (value) {
                        controller.setCustomerFilter(value ?? '');
                      },
                      items: customerNames.map((name) {
                        return DropdownMenuItem(
                          value: name,
                          child: Text(name),
                        );
                      }).toList(),
                    ),
                  ),

                  /// Material Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: TColors.info),
                    ),
                    child: DropdownButton<String>(
                      value: controller.selectedMaterial.value.isEmpty
                          ? null
                          : controller.selectedMaterial.value,
                      hint: const Text('Material'),
                      onChanged: (value) {
                        controller.setMaterialFilter(value ?? '');
                      },
                      items: materials.map((material) {
                        return DropdownMenuItem(
                          value: material,
                          child: Text(material.isEmpty ? 'All' : material),
                        );
                      }).toList(),
                    ),
                  ),

                  /// Date Picker
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: TColors.info),
                    ),
                    child: IconButton(
                      icon: const Icon(Iconsax.calendar),
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate:
                          controller.selectedDate.value ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          controller.setDateFilter(pickedDate);
                        }
                      },
                    ),
                  ),
                ],
              );
            }),

            // Filtered Sales List
            Expanded(
              child: Obx(() {
                final sales = controller.filteredSales.isEmpty && controller.selectedCustomer.value.isEmpty && controller.selectedMaterial.value.isEmpty && controller.selectedDate.value == null
                    ? controller.saleList
                    : controller.filteredSales;


                if (sales.isEmpty) {
                  return const Center(child: Text('No transactions found.'));
                }

                return ListView.builder(
                  itemCount: sales.length,
                  itemBuilder: (context, index) {
                    final sale = sales[index];
                    return SaleCard(
                      saleId: 'Sale',
                      customerName: sale.customer,
                      material: sale.material,
                      tons: sale.tons.toString(),
                      amount: (sale.tons * sale.pricePerUnit).toStringAsFixed(
                        2,
                      ),
                      backgroundColor: TColors.info,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
