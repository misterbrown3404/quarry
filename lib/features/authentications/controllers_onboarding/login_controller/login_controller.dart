import 'package:Quarry/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:Quarry/features/authentications/controllers_onboarding/controller/user_controller.dart';
import 'package:Quarry/utils/constants/image_strings.dart';
import 'package:Quarry/utils/helpers/network_manager.dart';
import 'package:Quarry/utils/popups/full_screen_loader.dart';
import 'package:Quarry/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{

  /// variable
  final email = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit(){
   // email.text = localStorage.read('REMEMBER_ME_EMAIL');
    //password.text = localStorage.read('REMEMBER_ME_PASSWORD');
    super.onInit();

  }

  void emailAndPasswordSignIn() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in .......', TImages.successfulRegistrationAnimation);

      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!loginKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Remember Me
      if(rememberMe.value){
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // login user with email and password authentication
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      // Remove loader
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();


    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }

  }

 Future <void> googleSignIn() async{
    try{
      TFullScreenLoader.openLoadingDialog('Logging you in .......', TImages.successfulRegistrationAnimation);
      //AuthenticationRepository.instance.siginWithGoogle();

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }
      // google authentication
      final userCredentials = await AuthenticationRepository.instance.sigInWithGoogle();

      // save user record
      await userController.saveUserRecord(userCredentials);

      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}