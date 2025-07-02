import 'package:Quarry/common/styles/spacing_style.dart';
import 'package:Quarry/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Quarry/features/shop/screens/customer/controller/customer_controller.dart';
import 'package:Quarry/features/shop/screens/customer/widgets/customer_model.dart';

class EditCustomer extends StatelessWidget {
  final CustomerModel customer;

  EditCustomer({Key? key, required this.customer}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerController>();

    _nameController.text = customer.customerName;
    _phoneController.text = customer.customerPhoneNumber;
    _priceController.text = customer.pricePerUnit;



    return Scaffold(

      body: SingleChildScrollView(

          child: Column(
            children: [
              TAppBar(showBackArrow: true, title: Text('Edit Customer')),

              Padding(
                padding: TSpacingStyle.paddingWithAppForHeight,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: "Name"),
                        validator: (value) =>
                        value == null || value.isEmpty ? "Enter a name" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(labelText: "Phone Number"),
                        validator: (value) =>
                        value == null || value.isEmpty ? "Enter a phone number" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(labelText: "Price"),
                        validator: (value) =>
                        value == null || value.isEmpty ? "Enter Price" : null,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await controller.updateCustomer(
                                customer.id,
                                _nameController.text.trim(),
                                _phoneController.text.trim(),
                                _priceController.text.trim(),

                              );
                              Get.back();
                              Get.snackbar("Success", "Customer updated successfully");
                            }
                          },
                          child: const Text("Save Changes"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
