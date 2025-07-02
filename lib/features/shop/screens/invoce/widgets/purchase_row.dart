import 'package:flutter/material.dart';

class PurchaseRow extends StatelessWidget {
  const PurchaseRow({super.key, required this.label, required this.value,});
 final String label;
 final String value;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}
