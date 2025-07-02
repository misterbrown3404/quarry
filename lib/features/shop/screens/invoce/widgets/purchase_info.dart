import 'package:flutter/material.dart';

class PurchaseInfo extends StatelessWidget {
  const PurchaseInfo({
    super.key,
    required this.material,
    required this.qty,
    required this.price,
  });

  final String material;
  final String qty;
  final String price;

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(material),
              Text(qty),
            ],
          ),
          Text(price),
        ],
      ),
    );
  }
}

