
import 'package:Quarry/data/repositories/authentication_repository/user_repository.dart';
import 'package:Quarry/features/authentications/models/user_model.dart';
import 'package:Quarry/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  /// save user record from any authentication provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        final nameParts = UserModel.namePart(
          userCredentials.user!.displayName ?? '',
        );

        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join('') : '',
          email: userCredentials.user!.email ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          companyName: userCredentials.user!.displayName?? '',
        );

        /// Save user
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data not saved',
        message:
            'Something went wrong while saving your data, you can resave your deta in your profile page',
      );
    }
  }
}
