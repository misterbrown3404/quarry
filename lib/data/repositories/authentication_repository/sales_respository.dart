import 'package:Quarry/features/shop/screens/sale/model/sales_model.dart';
import 'package:Quarry/features/shop/screens/transaction/model/transaction_model.dart';
import 'package:Quarry/utils/exceptions/firebase_exceptions.dart';
import 'package:Quarry/utils/exceptions/format_exceptions.dart';
import 'package:Quarry/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SalesRepository extends GetxController{
  static SalesRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<SaleModel>> saleStream(String userId) {
    return _db
        .collection('Sales')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => SaleModel.fromSnapshot(doc))
        .toList());
  }
  Future<void> addSale(SaleModel sales) async{
    try{
      await _db.collection('Sales').add(sales.toJson());
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const TFormatException();
    } on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong please try again';
    }
  }
}
