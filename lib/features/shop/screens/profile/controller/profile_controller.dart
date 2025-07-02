import 'package:Quarry/features/authentications/models/user_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (doc.exists) {
        user.value = UserModel.fromSnapshot(doc);
      }
    } catch (e) {
      print('Error fetching user: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
