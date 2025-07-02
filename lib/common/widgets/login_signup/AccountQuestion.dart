import 'package:Quarry/features/authentications/screens_onboarding/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountQuestion extends StatelessWidget {
  const AccountQuestion({
    super.key, required this.title, required this.subtitle, required this.onPressed,
  });
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        TextButton(onPressed: onPressed,child: Text(subtitle)),
      ],
    );
  }
}
