import 'package:Quarry/features/authentications/controllers_onboarding/login_controller/login_controller.dart';
import 'package:Quarry/utils/constants/colors.dart';
import 'package:Quarry/utils/constants/image_strings.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TGoogleLogin extends StatelessWidget {
  const TGoogleLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SizedBox(
      width: double.infinity,
      height: TSizes.containerHeight,
      child: OutlinedButton(
        onPressed: () => controller.googleSignIn(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(TImages.google),width: 24,height: 24,),
            SizedBox(width: TSizes.spaceBtwItems),
            Text(TTexts.signWithGoogle),
          ],
        ),
      ),
    );
  }
}
