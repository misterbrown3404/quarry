import 'package:Quarry/features/shop/screens/invoce/widgets/purchase_info.dart';
import 'package:Quarry/features/shop/screens/invoce/widgets/purchase_row.dart';
import 'package:Quarry/features/shop/screens/transaction/controller/transaction_contoller.dart';
import 'package:Quarry/utils/constants/colors.dart';
import 'package:Quarry/utils/constants/image_strings.dart';
import 'package:Quarry/utils/helpers/invoice_generator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:printing/printing.dart';
import 'package:get/get.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  final controller = Get.put(TransactionController());
  DateTime selectedMonth = DateTime.now(); // Track selected month
  bool get isReadyToGenerate =>
      controller.selectedCustomerMonth.value.isNotEmpty &&
          controller.selectedMonth.value != null;

  String _monthYearFormat(DateTime date) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return "${monthNames[date.month - 1]} ${date.year}";
  }

  @override
  void dispose() {
    // Clear filters when navigating away
    controller.clearFilters();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Invoice'),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Customer Info
            const Text(
              "Customer",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(TImages.user),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(() {
                    final customerNames = controller.customerList
                        .map((c) => c.customerName)
                        .toList();
                    if (controller.customerList.isEmpty) {
                      return const Text('No Customer Found');
                    }
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: TColors.info),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: controller.selectedCustomerMonth.value.isEmpty
                            ? null
                            : controller.selectedCustomerMonth.value,
                        hint: const Text('Customer'),
                        onChanged: (value) {
                          controller.selectedCustomerMonth(value ?? '');
                        },
                        items: customerNames.map((name) {
                          return DropdownMenuItem(
                            value: name,
                            child: Text(name),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// Month Picker
            const Text(
              "Month",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final picked = await showMonthPicker(
                  context: context,
                  initialDate: selectedMonth,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    selectedMonth = picked;
                  });
                  controller.setMonthFilter(picked);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _monthYearFormat(selectedMonth),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Icon(Iconsax.arrow_square_down),
                ],
              ),
            ),
            const Divider(height: 32),

            /// Purchases
            const Text(
              "Purchases",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                final selectedCustomer = controller.selectedCustomerMonth.value;
                final selectedMonth = controller.selectedMonth.value;

                // If no customer or month selected, show nothing or a message
                if (selectedCustomer.isEmpty || selectedMonth == null) {
                  return const Center(
                    child: Text('Please select a customer and month.'),
                  );
                }

                // Filtered sales for this selection
                final sales = controller.filteredSalesMonth;

                if (sales.isEmpty) {
                  return const Center(
                    child: Text('No transactions found for this customer and month.'),
                  );
                }

                // Compute total amount
                final totalAmount = sales.fold<double>(
                  0.0,
                      (sum, sale) => sum + (sale.tons * sale.pricePerUnit + (sale.transport ?? 0.0)),
                );

                // Compute total amount
                final totalTransport = sales.fold<double>(
                  0.0,
                      (sum, sale) => sum + (sale.transport ?? 0.0),
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Purchases list
                    SizedBox(
                  height: 100, // adjust as needed
                      child: ListView.builder(
                        itemCount: sales.length,
                        itemBuilder: (context, index) {
                          final sale = sales[index];
                          return PurchaseInfo(
                            material: sale.material,
                            qty: sale.tons.toString(),
                            price: (sale.tons * sale.pricePerUnit).toStringAsFixed(2),
                          );
                        },
                      ),
                    ),

                    const Divider(height: 32),
                    const Text(
                      "Transport",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    PurchaseRow(
                      label: "Total Transport",
                      value: totalTransport.toStringAsFixed(2),
                    ),


                    const Divider(height: 32),

                    const Text(
                      "Total",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    PurchaseRow(
                      label: "Total Amount",
                      value: totalAmount.toStringAsFixed(2),
                    ),

                  ],
                );
              })

            ),

            const Divider(height: 30),


            /// Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:  isReadyToGenerate ? () async {
                      // Get selected customer details
                      final selectedCustomerModel = controller.customerList.firstWhereOrNull(
                            (c) => c.customerName == controller.selectedCustomerMonth.value,
                      );

                      final pdfBytes = await InvoiceGenerator.generateInvoicePdf(
                        customerName: selectedCustomerModel?.customerName ?? "Customer",
                        customerPhone: selectedCustomerModel?.customerPhoneNumber ?? "N/A",
                        month: _monthYearFormat(selectedMonth),
                        purchases: controller.filteredSalesMonth.map((sale) {
                          return {
                            'material': sale.material,
                            'qty': sale.tons.toString(),
                            'price': (sale.tons * sale.pricePerUnit).toStringAsFixed(2),
                          };
                        }).toList(),
                        totalAmount: controller.filteredSalesMonth.fold<double>(
                          0.0,
                              (sum, sale) => sum + (sale.tons * sale.pricePerUnit),
                        ).toStringAsFixed(2),
                      );

                      await Printing.layoutPdf(onLayout: (_) => pdfBytes);
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Download"),
                        Icon(Iconsax.document_download),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed:  isReadyToGenerate ?() async {
                      // Get selected customer details
                      final selectedCustomerModel = controller.customerList.firstWhereOrNull(
                            (c) => c.customerName == controller.selectedCustomerMonth.value,
                      );

                      final pdfBytes = await InvoiceGenerator.generateInvoicePdf(
                        customerName: selectedCustomerModel?.customerName ?? "Customer",
                        customerPhone: selectedCustomerModel?.customerPhoneNumber ?? "N/A",
                        month: _monthYearFormat(selectedMonth),
                        purchases: controller.filteredSalesMonth.map((sale) {
                          return {
                            'material': sale.material,
                            'qty': sale.tons.toString(),
                            'price': (sale.tons * sale.pricePerUnit).toStringAsFixed(2),
                          };
                        }).toList(),
                        totalAmount: controller.filteredSalesMonth.fold<double>(
                          0.0,
                              (sum, sale) => sum + (sale.tons * sale.pricePerUnit),
                        ).toStringAsFixed(2),

                      );

                      await Printing.sharePdf(
                        bytes: pdfBytes,
                        filename: 'invoice.pdf',
                      );
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.info,
                      foregroundColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Share"),
                        Icon(Iconsax.share),
                      ],
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
