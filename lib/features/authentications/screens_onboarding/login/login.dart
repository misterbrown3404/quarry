import 'package:Quarry/common/styles/spacing_style.dart';
import 'package:Quarry/common/widgets/login_signup/AccountQuestion.dart';
import 'package:Quarry/common/widgets/login_signup/TGoogleLogin.dart';
import 'package:Quarry/common/widgets/login_signup/TFormDivider.dart';
import 'package:Quarry/features/authentications/screens_onboarding/login/widget/Tform.dart';
import 'package:Quarry/common/widgets/login_signup/TloginHeader.dart';
import 'package:Quarry/features/authentications/screens_onboarding/signup/signup.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:Quarry/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppForHeight,
          child: Column(
            children: [
              /// Title and Subtitle
              TLoginHeader(title: TTexts.loginTitle, subtitle: TTexts.loginSubTitle,),
              SizedBox(height: TSizes.spaceBtwSections),
              ///Form
              TForm(),

              ///Divider
              TFormDivider(dark: dark),
              SizedBox(height: TSizes.spaceBtwSections),

              ///Footer

              TGoogleLogin(),
              SizedBox(height: TSizes.spaceBtwSections),

              /// Ask Account
              SizedBox(height: TSizes.spaceBtwSections),
              AccountQuestion(title: TTexts.donHaveAccount, subtitle: TTexts.logSignUp,onPressed: ()=> Get.to(SignUpScreen()),),
            ],
          ),
        ),
      ),
    );
  }
}
