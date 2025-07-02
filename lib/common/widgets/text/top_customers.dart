import 'package:Quarry/features/shop/screens/customer/model/topCustomer_model.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';


class TopCustomers extends StatelessWidget {
  const TopCustomers({super.key, required this.topCustomers});

  final List<TopCustomerModel> topCustomers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: TSizes.defaultSpace,
        right: TSizes.defaultSpace,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTexts.topCustomers,
              style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: TSizes.spaceBtwItems),

          /// Header Row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(TTexts.no,
                    style: Theme.of(context).textTheme.labelMedium),
                Expanded(
                    child: Text(TTexts.customerName,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium)),
                Text(TTexts.totalAmount,
                    style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
          SizedBox(height: TSizes.spaceBtwItems / 2),

          /// Customer List
          if (topCustomers.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No sales data'),
            )
          else
            for (int index = 0; index < topCustomers.length; index++)
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: TSizes.sm / 2, horizontal: TSizes.sm),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${index + 1}.'),
                        Expanded(
                          child: Text(
                            topCustomers[index].customer,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          topCustomers[index]
                              .totalAmount
                              .toStringAsFixed(2),
                        ),
                      ],
                    ),
                    if (index < topCustomers.length - 1)
                      Divider(
                          height: TSizes.spaceBtwItems, thickness: 0.5),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
