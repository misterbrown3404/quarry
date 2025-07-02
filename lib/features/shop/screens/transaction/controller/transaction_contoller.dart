import 'package:Quarry/data/repositories/authentication_repository/sales_respository.dart';
import 'package:Quarry/data/repositories/customer_respository.dart';
import 'package:Quarry/features/authentications/models/user_model.dart';
import 'package:Quarry/features/shop/screens/customer/model/topCustomer_model.dart';
import 'package:Quarry/features/shop/screens/customer/widgets/customer_model.dart';
import 'package:Quarry/features/shop/screens/sale/model/sales_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();



  // New observable for top customers
  RxList<TopCustomerModel> topCustomers = <TopCustomerModel>[].obs;
  Rx<UserModel> user = UserModel.empty().obs;
  RxBool isLoading = true.obs;
  // Filter criteria
  var selectedCustomer = ''.obs;
  var selectedMaterial = ''.obs;
  var selectedCustomerMonth = ''.obs;
  var selectedDate = Rxn<DateTime>();

  // New totals
  RxDouble totalProfit = 0.0.obs;
  RxInt totalSales = 0.obs;

  // Filtered sales computed automatically
  RxList<SaleModel> filteredSales = <SaleModel>[].obs;
  RxList<SaleModel> filteredSalesMonth = <SaleModel>[].obs;
  final CustomerRepository _customerrepo = CustomerRepository();
  RxList<CustomerModel> customerList = <CustomerModel>[].obs;
  final SalesRepository _repo = SalesRepository();
  RxList<SaleModel> saleList = <SaleModel>[].obs;
  /// Selected month filter (separate from date filter)
  Rxn<DateTime> selectedMonth = Rxn<DateTime>();


  @override
  void onInit() {
    super.onInit();
    fetchCustomers();
    fetchSales();
    fetchUser();
    ever(saleList, (_) {
      computeTotals();
      computeTopCustomers();
      applyFilters();
      applyMonthFilter();
    });
  }

  Future<void> fetchSales() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    saleList.bindStream(_repo.saleStream(userId));

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


  /// Compute total profit and total sales
  void computeTotals() {
    double profit = 0.0;

    for (final sale in saleList) {
      profit += sale.tons * sale.pricePerUnit;
    }

    totalProfit.value = profit;
    totalSales.value = saleList.length;
  }
  /// Compute total amounts per customer
  void computeTopCustomers() {
    final Map<String, double> totals = {};

    for (final sale in saleList) {
      final amount = sale.tons * sale.pricePerUnit;
      totals.update(
        sale.customer,
            (existing) => existing + amount,
        ifAbsent: () => amount,
      );
    }

    final sorted = totals.entries
        .map((e) => TopCustomerModel(customer: e.key, totalAmount: e.value))
        .toList()
      ..sort((a, b) => b.totalAmount.compareTo(a.totalAmount));

    topCustomers.assignAll(sorted.take(5));
  }

/// Fetch customers
  Future<void> fetchCustomers() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    customerList.bindStream(_customerrepo.customerStream(userId));
  }

  /// Set customer filter
  void setCustomerFilter(String customer) {
    selectedCustomer.value = customer;
    applyFilters();
  }
  /// Set customer filter
  void setCustomerFilterMonth(String customer) {
    selectedCustomerMonth.value = customer;
    applyMonthFilter();
  }

  /// Set material filter
  void setMaterialFilter(String material) {
    selectedMaterial.value = material;
    applyFilters();
  }

  /// Set date filter
  void setDateFilter(DateTime date) {
    selectedDate.value = date;
    applyFilters();
  }

  /// set month filter
  void setMonthFilter(DateTime month) {
    selectedMonth.value = month;
    applyMonthFilter();
  }

  /// Clear all filters
  void clearFilters() {
    selectedCustomer.value = '';
    selectedMaterial.value = '';
    selectedDate.value = null;
    applyFilters();
    selectedCustomerMonth.value = '';
    selectedMonth.value = null;
    filteredSalesMonth.clear();
    applyMonthFilter();
  }

  /// Apply all filters to allSales
  void applyFilters() {
    print('Running applyFilters...');
    print('saleList length: ${saleList.length}');

    final customer = selectedCustomer.value.trim().toLowerCase();
    final material = selectedMaterial.value.trim().toLowerCase();
    final date = selectedDate.value;

    filteredSales.assignAll(
      saleList.where((sale) {
        print('Evaluating sale: ${sale.customer}, ${sale.material}, ${sale.date}');

        final matchesCustomer = customer.isEmpty ||
            sale.customer.toLowerCase() == customer;
        final matchesMaterial = material.isEmpty ||
            sale.material.toLowerCase() == material;
        final matchesDate = date == null ||
            _isSameDate(sale.date, date);

        print('matchesCustomer: $matchesCustomer, matchesMaterial: $matchesMaterial, matchesDate: $matchesDate');
        return matchesCustomer && matchesMaterial && matchesDate;
      }).toList(),
    );

    print('Filtered sales length: ${filteredSales.length}');
  }
  /// Apply month filter only
  void applyMonthFilter() {
    print('Running applyMonthFilter...');
    print('saleList length: ${saleList.length}');

    final month = selectedMonth.value;
    final customer = selectedCustomerMonth.value.trim().toLowerCase();

    filteredSalesMonth.assignAll(
      saleList.where((sale) {
        final matchesCustomer = customer.isEmpty ||
            sale.customer.toLowerCase() == customer;

        final matchesMonth = month == null ||
            isSameMonth(sale.date, month);

        print('Evaluating sale: ${sale.customer}, date: ${sale.date}, matchesCustomer: $matchesCustomer, matchesMonth: $matchesMonth');
        return matchesCustomer && matchesMonth;
      }).toList(),
    );

    print('Filtered sales length: ${filteredSalesMonth.length}');
  }


  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }

  @override
  void onClose() {
    // Reset filters when controller is disposed
    clearFilters();
    super.onClose();
  }

}
