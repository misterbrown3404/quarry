import 'package:flutter/material.dart';

class SaleCard extends StatelessWidget {
  final String saleId;
  final String customerName;
  final String amount;
  final String material;
  final String tons;
  final VoidCallback? onTap;
  final Color backgroundColor;

  const SaleCard({
    super.key,
    required this.saleId,
    required this.customerName,
    required this.amount,
    required this.material,
    required this.tons,
    this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // optional click action
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          //color: TColors.info,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: backgroundColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Sale Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(saleId),
                const SizedBox(height: 4),
                Text(material),
                const SizedBox(height: 4,),
                Text(tons),
                const SizedBox(height: 4),
                Text(customerName),
              ],
            ),

            // Amount
            Text(amount),
          ],
        ),
      ),
    );
  }
}
