import 'package:Quarry/common/styles/spacing_style.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:Quarry/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});
 final  String image, title, subTitle;
 final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: TSpacingStyle.paddingWithAppForHeight * 2,
        child: Column(
          children: [
            /// Image
            Lottie.asset(image,width: THelperFunctions.screenWidth() * 0.6,),
            SizedBox(height: TSizes.spaceBtwSections),

            /// Title & subTitle
            Text(title,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
            SizedBox(height: TSizes.spaceBtwItems),
            Text(subTitle,style: Theme.of(context).textTheme.labelLarge,textAlign: TextAlign.center,),
            SizedBox(height: TSizes.spaceBtwSections),

            ///Button

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: onPressed, child: Text(TTexts.tContinue)),
            ),

          ],
        ),
        )
      ),
    );
  }
}
