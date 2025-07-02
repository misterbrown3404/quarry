import 'package:Quarry/features/authentications/screens_onboarding/login/login.dart';
import 'package:Quarry/features/authentications/screens_onboarding/signup/signup.dart';
import 'package:Quarry/features/authentications/screens_onboarding/widget/onboarding_page.dart';
import 'package:Quarry/utils/constants/image_strings.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinalBoard extends StatelessWidget {
  const FinalBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          OnBoardingPage(
            image: TImages.onBoardingImage5,
            title: TTexts.onBoardingTitle5,
            subTitle: TTexts.onBoardingSubTitle5,
          ),
          SizedBox(height: TSizes.defaultSpace),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: TSizes.containerWidth,
                height: TSizes.containerHeight,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => LoginScreen());
                  },
                  child: Text(TTexts.signIn),
                ),
              ),
              SizedBox(
                width: TSizes.containerWidth,
                height: TSizes.containerHeight,
                child: OutlinedButton(
                  onPressed: () {
                    Get.to(()=>SignUpScreen());
                  },
                  child: Text(TTexts.signUp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
