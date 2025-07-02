import 'package:Quarry/features/authentications/controllers_onboarding/signup_controller/signup_controller.dart';
import 'package:Quarry/utils/constants/colors.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:Quarry/utils/constants/text_strings.dart';
import 'package:Quarry/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSignUpForm extends StatelessWidget {
  const TSignUpForm({super.key, required this.dark});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            /// Full Name
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        TValidator.validateEmptyText('First name', value),
                    expands: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: TTexts.firstName,
                    ),
                  ),
                ),
                SizedBox(width: TSizes.spaceBtwInputFields),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Last name', value),
                    expands: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: TTexts.lastName,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            /// Company Name
            TextFormField(
                controller: controller.companyName,
                validator: (value) =>
                    TValidator.validateEmptyText('Company name', value),
                expands: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.house),
                  labelText: TTexts.company,
                ),
              ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            /// Phone Number
            TextFormField(
                controller: controller.phoneNumber,
                validator: (value) =>
                    TValidator.validatePhoneNumber(value),
                expands: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.mobile),
                  labelText: TTexts.phoneNo,
                ),
              ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            ///Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct),
                labelText: TTexts.email,
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            ///Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                validator: (value) => TValidator.validatePassword(value),
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(
                      controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Terms & Condition
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Obx(
                        () => Checkbox(
                          value: controller.privacyPolicy.value,
                          onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value,
                        ),
                      ),
                    ),
                    SizedBox(width: TSizes.spaceBtwInputFields),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${TTexts.iAgreeTo} ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextSpan(
                            text: '${TTexts.privacyPolicy} ',
                            style: Theme.of(context).textTheme.labelMedium!
                                .apply(
                                  color: dark ? TColors.white : TColors.primary,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                          TextSpan(
                            text: '${TTexts.and} ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),

                          TextSpan(
                            text: TTexts.termsOfUse,
                            style: Theme.of(context).textTheme.labelMedium!
                                .apply(
                                  color: dark ? TColors.white : TColors.primary,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            ///Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signUp(),
                child: Text(TTexts.signUp),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),

            // ///Create Account Button
            // SizedBox(
            //   width: double.infinity,
            //   child: OutlinedButton(
            //     onPressed: () {},
            //     child: Text(TTexts.createAccount),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
