import 'package:Quarry/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeBox extends StatelessWidget {
  const HomeBox({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.number,
    this.isCurrency = false,
  });

  final String title;
  final Color backgroundColor;
  final num number;
  final bool isCurrency; // Whether to format as money

  @override
  Widget build(BuildContext context) {
    final formatted = isCurrency
        ? NumberFormat.currency(locale: 'en_NG', symbol: '')
        .format(number)
        : NumberFormat.compact().format(number);

    return Container(
      width: 140,
      height: 100,
      padding: EdgeInsets.all(TSizes.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: backgroundColor, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Text(
            formatted,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
