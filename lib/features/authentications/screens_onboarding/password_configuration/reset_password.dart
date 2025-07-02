import 'package:Quarry/utils/constants/image_strings.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:Quarry/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=> Get.back(), icon: Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(children: [
          /// Image
          Image(image: AssetImage(TImages.deliveredEmailIllustration),width: THelperFunctions.screenWidth() * 0.6,),
          SizedBox(height: TSizes.spaceBtwSections),

          /// Title & subTitle
          Text(TTexts.changeYourPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
          SizedBox(height: TSizes.spaceBtwItems),
          Text(TTexts.changeYourPasswordSubTitle,style: Theme.of(context).textTheme.labelLarge,textAlign: TextAlign.center,),
          SizedBox(height: TSizes.spaceBtwSections),

          ///Button

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=>Get.back(), child: Text(TTexts.done)),
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: TextButton(onPressed: ()=>Get.back(), child: Text(TTexts.resendEmail)),
          )
        ]),
      ),
      ),
    );
  }
}
