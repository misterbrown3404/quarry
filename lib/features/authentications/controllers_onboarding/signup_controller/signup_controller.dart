import 'package:Quarry/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:Quarry/data/repositories/authentication_repository/user_repository.dart';
import 'package:Quarry/features/authentications/models/user_model.dart';
import 'package:Quarry/features/authentications/screens_onboarding/signup/verify_email.dart';
import 'package:Quarry/utils/constants/image_strings.dart';
import 'package:Quarry/utils/helpers/network_manager.dart';
import 'package:Quarry/utils/popups/full_screen_loader.dart';
import 'package:Quarry/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///variable
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final companyName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signUp() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'We are processing your information',
        TImages.successfulRegistrationAnimation,
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading(); // ✅ stop loader on validation fail
        return;
      }

      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading(); // ✅ stop loader on policy reject
        TLoaders.errorSnackBar(
          title: 'Accept Privacy Policy',
          message:
          'To create an account, you must accept the Privacy Policy & Terms of Use',
        );
        return;
      }

      final userCredential = await AuthenticationRepository.instance
          .registerUserWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        companyName: companyName.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      TFullScreenLoader.stopLoading(); // ✅ Stop loader on success

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message:
        'Your account has been created. Please verify your email to continue',
      );

      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading(); // ✅ Ensure it's stopped on error
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

}

