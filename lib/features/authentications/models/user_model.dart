import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String email;
  String profilePicture;
  String phoneNumber;
  String companyName;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePicture,
    required this.phoneNumber,
    required this.companyName,
  });

  String get fullName => '$firstName $lastName';
   String get company => companyName;

  static List<String> namePart(fullName) => fullName.split(' ');

  static UserModel empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    profilePicture: '',
    phoneNumber: '',
    companyName: '',
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'profilePicture': profilePicture,
      'phoneNumber': phoneNumber,
      'companyName': companyName,
    };
  }

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['firstname'] ?? '',
        lastName: data['lastname'] ?? '',
        email: data['email'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        companyName: data['companyName'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
