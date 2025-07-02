import 'package:Quarry/common/widgets/box/home_box.dart';
import 'package:Quarry/common/widgets/text/top_customers.dart';
import 'package:Quarry/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:Quarry/features/shop/screens/sale/sale.dart';
import 'package:Quarry/features/shop/screens/transaction/controller/transaction_contoller.dart';
import 'package:Quarry/utils/constants/colors.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// App Bar
            Obx((){
              final user = controller.user.value;
                return THomeAppBar(title:  '${TTexts.homeAppbarTitle} ',name: user.lastName,);}),
            SizedBox(height: TSizes.spaceBtwSections),
            /// Search Bar
           // TSearchContainer(text: TTexts.search, onTap: () {},),
            //HomeBox(title: 'Total Profit', backgroundColor: TColors.info,),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeBox(
                    title: 'Total Profit',
                    backgroundColor: Colors.blue,
                    number: controller.totalProfit.value,
                    isCurrency: true,
                  ),
                  HomeBox(
                    title: 'Total Sales',
                    backgroundColor: Colors.green,
                    number: controller.totalSales.value,
                    isCurrency: false,
                  ),
                ],
              );
            }),

            SizedBox(height: TSizes.spaceBtwSections),
            Obx(() {
              if (controller.topCustomers.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: Text('No Top Customers')),
                );
              }
              return TopCustomers(topCustomers: controller.topCustomers);
            }),

            /// Popular Courses


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()=>(Get.to(Sale())),
      child: const Icon(Iconsax.add),),
    );
  }
}
