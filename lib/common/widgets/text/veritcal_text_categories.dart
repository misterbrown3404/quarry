import 'package:Quarry/utils/constants/sizes.dart';
import 'package:flutter/material.dart';


class TVerticalText extends StatelessWidget {
  const TVerticalText({
    super.key,
    required this.title,
    required this.backgroundColor,
    this.onTab,
  });

  final String title;
  final Color backgroundColor;
  final void Function()? onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Padding(
        padding: EdgeInsets.only(left: TSizes.defaultSpace),
        child: Column(
          children: [
            //TSectionHeading(),

            ///  Courses
            SizedBox(height: TSizes.spaceBtwItems),

            SizedBox(
              height: 80,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: TSizes.spaceBtwItems),
                  child: Column(
                    children: [
                      /// Circular Icon
                      Container(
                        width: 70,
                        height: 34,
                        padding: EdgeInsets.all(TSizes.sm),
                        decoration: BoxDecoration(
                          //color: TColors.info,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: backgroundColor),
                        ),
                        child: Center(child: Text(title)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
