import 'package:flutter/material.dart';

class FilterDropdownButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Widget? child;

  const FilterDropdownButton({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    required this.backgroundColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: backgroundColor),
      ),
      child: child ??
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label),
                const SizedBox(width: 6),
                Icon(icon),
              ],
            ),
          ),
    );
  }
}
