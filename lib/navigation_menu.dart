import 'package:Quarry/features/shop/screens/transaction/transaction.dart';
import 'package:Quarry/utils/constants/colors.dart';
import 'package:Quarry/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/shop/screens/home/home.dart';
import 'features/shop/screens/customer/customer.dart';
import 'features/shop/screens/invoce/invoice.dart' show Invoice;

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : TColors.white,
          indicatorColor: darkMode ? TColors.info: TColors.info,
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home,color: darkMode ? TColors.white : TColors.black,), label: 'Home'),
            NavigationDestination(
              icon: Icon(Iconsax.money,color: darkMode ? TColors.white : TColors.black),
              label: 'Transactions',
            ),
            NavigationDestination(icon: Icon(Iconsax.people,color: darkMode ? TColors.white : TColors.black), label: 'Customers'),
            NavigationDestination(icon: Icon(Iconsax.receipt,color: darkMode ? TColors.white : TColors.black), label: 'Invoice'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    Transaction(),
    Customer(),
    Invoice(),
  ];
}
