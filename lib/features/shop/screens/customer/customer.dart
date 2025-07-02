import 'package:Quarry/common/widgets/appbar/appbar.dart';
import 'package:Quarry/common/widgets/custom_shapes/container/search_container.dart';
import 'package:Quarry/features/shop/screens/customer/controller/customer_controller.dart';
import 'package:Quarry/features/shop/screens/customer/edit_customer.dart';
import 'package:Quarry/features/shop/screens/customer/widgets/customer_card.dart';
import 'package:Quarry/features/shop/screens/customer/widgets/customer_model.dart';
import 'package:Quarry/utils/constants/colors.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:Quarry/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'add_customer.dart';

class Customer extends StatelessWidget {
  const Customer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Scaffold(
      body: Column(
        children: [
          TAppBar(title: Text('Customer')),
          TSearchContainer( onChanged: (val) => controller.searchQuery.value = val,),
          SizedBox(height: TSizes.spaceBtwSections),
          Expanded(
            child: Obx(() {
              if (controller.customerList.isEmpty) {
                return const Center(child: Text('No customers found.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                itemCount: controller.filteredCustomers.length,
                itemBuilder: (context, index) {
                  final customer = controller.filteredCustomers[index];
                  return Dismissible(
                    key: Key(customer.id), // Make sure your model has an `id`
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) async {
                      await controller.deleteCustomer(customer.id);
                      TLoaders.successSnackBar(title: 'Deleted', message: '${customer.customerName} removed');
                    },
                    child: CustomerCard(
                      customerName: customer.customerName,
                      phoneNumber: customer.customerPhoneNumber,
                      price: customer.pricePerUnit,
                      onTap: () {
                        Get.to(() => EditCustomer(customer: customer));
                      }, // edit later
                      backgroundColor: TColors.info,
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            (Get.to(AddCustomer())), child: const Icon(Iconsax.add)),

    );
  }
}
