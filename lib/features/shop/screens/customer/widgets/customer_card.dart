import 'package:Quarry/common/widgets/custom_shapes/container/t_circular_image.dart';
import 'package:Quarry/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final String phoneNumber;
  final String customerName;
  final String price;
  final VoidCallback onTap;
  final Color backgroundColor;

  const CustomerCard({
    super.key,
    required this.phoneNumber,
    required this.customerName,
    required this.price,
    required this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: backgroundColor.withOpacity(0.6)),
        ),
        child: Row(
          children: [
            /// Avatar
            TCircularImage(image: TImages.user, width: 50, height: 50),

            const SizedBox(width: 12),

            /// Name & Phone
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customerName,
                ),
                const SizedBox(height: 4),
                Text(
                  phoneNumber,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
