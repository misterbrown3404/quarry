import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class TLoginHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const TLoginHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: TSizes.sm),
        Text(subtitle, style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}
