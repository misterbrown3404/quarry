import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String id;
  final String customerName;
  final String customerPhoneNumber;
  final String userId;
  final String pricePerUnit;

  CustomerModel({
    required this.id,
    required this.customerName,
    required this.customerPhoneNumber,
    required this.userId,
    required this.pricePerUnit,
  });

  static CustomerModel empty() => CustomerModel(
    id: '',
    customerName: '',
    customerPhoneNumber: '',
    userId: '',
    pricePerUnit: '',
  );

  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'customerPhoneNumber': customerPhoneNumber,
      'userId': userId,
      'pricePerUnit': pricePerUnit,
    };
  }

  factory CustomerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document,
      ) {
    final data = document.data();
    if (data != null) {
      return CustomerModel(
        id: document.id,
        customerName: data['customerName'] ?? '',
        customerPhoneNumber: data['customerPhoneNumber'] ?? '',
        userId: data['userId'] ?? '',
        pricePerUnit: data['pricePerUnit'] ?? '',
      );
    } else {
      return CustomerModel.empty();
    }
  }
}
