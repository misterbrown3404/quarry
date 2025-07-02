import 'package:Quarry/data/repositories/customer_respository.dart';
import 'package:Quarry/features/shop/screens/customer/customer.dart';
import 'package:Quarry/features/shop/screens/customer/widgets/customer_model.dart';
import 'package:Quarry/utils/constants/image_strings.dart';
import 'package:Quarry/utils/helpers/network_manager.dart';
import 'package:Quarry/utils/popups/full_screen_loader.dart';
import 'package:Quarry/utils/popups/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  static CustomerController get instance => Get.find();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final priceController = TextEditingController();
  GlobalKey<FormState> customerFormKey = GlobalKey<FormState>();
  final CustomerRepository _repo = CustomerRepository();
  RxList<CustomerModel> customerList = <CustomerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCustomers();
  }

  Future<void> updateCustomer(
      String id,
      String name,
      String phone,
      String price
      ) async {
    final data = {
      'customerName': name,
      'customerPhoneNumber': phone,
      'pricePerUnit' : price
    };

    await _repo.updateCustomer(id, data);
  }

  Future<void> fetchCustomers() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    customerList.bindStream(_repo.customerStream(userId));
  }
  final RxString searchQuery = ''.obs;

  List<CustomerModel> get filteredCustomers {
    if (searchQuery.value.isEmpty) return customerList;
    return customerList
        .where((c) => c.customerName
        .toLowerCase()
        .contains(searchQuery.value.toLowerCase()))
        .toList();
  }
  Future<void> deleteCustomer(String id) async {
    await FirebaseFirestore.instance.collection('Customers').doc(id).delete();
  }

  void submitCustomerForm() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      TFullScreenLoader.openLoadingDialog(
        'We are adding your customer record',
        TImages.doneIllustration,
      );
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!customerFormKey.currentState!.validate()) return;

      final customer = CustomerModel(
        id: '',
        customerName: nameController.text.trim(),
        customerPhoneNumber: phoneController.text.trim(),
        pricePerUnit: priceController.text.trim(),
        userId: userId,
      );

      // Add customer to Firestore and get DocumentReference
      final docRef = await _repo.addCustomer(customer);

      // Optional: If you want to store the ID inside the document too (not required)
      await docRef.update({'id': docRef.id});
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Success',
        message: 'Sale record added successfully',
      );
      Get.back();
      clearForm();
    } catch (e) {
      TFullScreenLoader.stopLoading(); // ✅ Ensure it's stopped on error
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void clearForm() {
    nameController.clear();
    phoneController.clear();
    priceController.clear();
    update(); // If using Obx widgets
  }
}
