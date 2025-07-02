import 'package:Quarry/features/shop/screens/customer/widgets/customer_model.dart';
import 'package:Quarry/utils/exceptions/firebase_exceptions.dart';
import 'package:Quarry/utils/exceptions/format_exceptions.dart';
import 'package:Quarry/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomerRepository extends GetxController{
  static CustomerRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<List<CustomerModel>> customerStream(String userId) {
    return _db
        .collection('Customers')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => CustomerModel.fromSnapshot(doc))
        .toList());
  }
  Future<void> updateCustomer(String id, Map<String, dynamic> data) async {
    try {
      await _db
          .collection('Customers')
          .doc(id)
          .update(data);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }


  Future<DocumentReference> addCustomer(CustomerModel customer) async{
    try{
      final docRef = await FirebaseFirestore.instance
          .collection('Customers')
          .add(customer.toJson());
      return docRef;
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
