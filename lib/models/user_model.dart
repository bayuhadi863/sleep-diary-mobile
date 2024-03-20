import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String name;
  String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  static UserModel empty() => UserModel(id: '', name: '', email: '');

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }

  /// Factory method to create a UserModel from a DocumentSnapshot
  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return UserModel(
      id: documentSnapshot.id,
      name: data['name'],
      email: data['email'],
    );
  }
}
