import 'package:cloud_firestore/cloud_firestore.dart';

class SaleModel {
  final String customer;
  final String material;
  final double tons;
  final double pricePerUnit;
  final DateTime date;
  final String userId;
  final double? transport;

  SaleModel({
    required this.customer,
    required this.material,
    required this.tons,
    required this.pricePerUnit,
    required this.date,
    required this.userId,
    this.transport,
  });

  static SaleModel empty() => SaleModel(
    customer: '',
    material: '',
    tons: 0.0, // Added default value for double
    pricePerUnit: 0.0, // Changed to double
    date: DateTime.now(),
    userId: '',
    transport: 0.0
  );

  Map<String, dynamic> toJson() {
    return {
      'customer': customer,
      'material': material,
      'tons': tons,
      'pricePerUnit': pricePerUnit,
      'date': Timestamp.fromDate(date),
      'userId': userId,
      'transport': transport
    };
  }

  factory SaleModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Handle number conversion safely
      double parseDouble(dynamic value) {
        if (value is double) return value;
        if (value is int) return value.toDouble();
        if (value is String) return double.tryParse(value) ?? 0.0;
        return 0.0;
      }

      return SaleModel(
        customer: data['customer']?.toString() ?? '',
        material: data['material']?.toString() ?? '',
        tons: parseDouble(data['tons']),
        pricePerUnit: parseDouble(data['pricePerUnit']),
        date: (data['date'] as Timestamp).toDate(),
        userId: data['userId']?.toString() ?? '',
        transport: parseDouble(data['transport']),
      );
    }
    return SaleModel.empty();
  }
}