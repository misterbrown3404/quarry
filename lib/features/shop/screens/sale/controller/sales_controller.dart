import 'package:Quarry/data/repositories/authentication_repository/sales_respository.dart';
import 'package:Quarry/features/shop/screens/customer/widgets/customer_model.dart';
import 'package:Quarry/features/shop/screens/sale/model/sales_model.dart';
import 'package:Quarry/utils/constants/image_strings.dart';
import 'package:Quarry/utils/helpers/network_manager.dart';
import 'package:Quarry/utils/popups/full_screen_loader.dart';
import 'package:Quarry/utils/popups/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting

class SalesController extends GetxController {
  static SalesController get instance => Get.find();

  // Form fields
  String? selectedCustomer;
  String? selectedMaterial;
  final tonsController = TextEditingController();
  final priceController = TextEditingController();
  final dateController = TextEditingController();
  final transportController = TextEditingController();
  final GlobalKey<FormState> saleFormKey = GlobalKey<FormState>();

  // Repository
  final SalesRepository _repo = SalesRepository();

  // Observables
  final RxList<CustomerModel> customerList = <CustomerModel>[].obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchCustomers();
    // Initialize date controller with today's date
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }
  void updateCustomerPrice() {
    if (selectedCustomer == null) return;

    // Find the customer
    final customer = customerList.firstWhereOrNull(
          (c) => c.customerName == selectedCustomer,
    );

    if (customer != null) {
      priceController.text = customer.pricePerUnit;
    }
  }


  Future<void> fetchCustomers() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Customers')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      customerList.value = snapshot.docs
          .map((doc) => CustomerModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Failed to fetch customers');
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDate.value = picked;
      dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  void submitSaleForm() async {
    try {
      // Validate network connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(title: 'No Internet', message: 'Please check your connection');
        return;
      }

      // Validate form
      if (!saleFormKey.currentState!.validate()) return;

      // Validate selections
      if (selectedCustomer == null || selectedMaterial == null) {
        TLoaders.errorSnackBar(
          title: 'Incomplete',
          message: 'Please select both Customer and Material',
        );
        return;
      }

      // Parse numeric values
      final tons = double.tryParse(tonsController.text.trim()) ?? 0.0;
      final pricePerUnit = double.tryParse(priceController.text.trim()) ?? 0.0;
      final transport = double.tryParse(transportController.text.trim()) ?? 0.0;

      // Validate numeric inputs
      if (tons <= 0 || pricePerUnit <= 0) {
        TLoaders.errorSnackBar(
          title: 'Invalid Values',
          message: 'Please enter valid numbers greater than 0',
        );
        return;
      }

      // Parse date (assuming format dd/MM/yyyy)
      final date = selectedDate.value ??
          DateFormat('dd/MM/yyyy').parse(dateController.text.trim());

      // Show loading indicator
      TFullScreenLoader.openLoadingDialog(
        'Processing your sale...',
        TImages.doneIllustration,
      );

      // Create sale model
      final sale = SaleModel(
        customer: selectedCustomer!,
        material: selectedMaterial!,
        tons: tons,
        pricePerUnit: pricePerUnit,
        date: date,
        userId: FirebaseAuth.instance.currentUser!.uid,
        transport: transport
      );

      // Add sale to repository
      await _repo.addSale(sale);

      // Show success and clear form
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Success',
        message: 'Sale record added successfully',
      );
      clearForm();

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }

  void clearForm() {
    selectedCustomer = null;
    selectedMaterial = null;
    tonsController.clear();
    priceController.clear();
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    selectedDate.value = null;
    transportController.clear();
    update();
  }
}