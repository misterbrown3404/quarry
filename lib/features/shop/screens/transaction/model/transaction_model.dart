import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String userId;
  final String customerName;
  final String material;
  final double amount;
  final Timestamp timestamp; // Use Timestamp for date in Firestore

  TransactionModel({
    required this.id,
    required this.userId,
    required this.customerName,
    required this.material,
    required this.amount,
    required this.timestamp,
  });

  // Factory constructor to create a TransactionModel from a Firestore document snapshot
  factory TransactionModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TransactionModel(
      id: document.id,
      userId: data['userId'] ?? '',
      customerName: data['customerName'] ?? '',
      material: data['material'] ?? '',
      amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
      timestamp: data['timestamp'] as Timestamp? ?? Timestamp.now(),
    );
  }

  // Method to convert TransactionModel to a Map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'customerName': customerName,
      'material': material,
      'amount': amount,
      'timestamp': timestamp,
    };
  }
}