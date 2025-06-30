// lib/model/user.dart

import 'package:sikilap/model/identifier_model.dart';

class User extends IdentifierModel {
  final String email, firstName, lastName;
  final String role; // <-- INI YANG DITAMBAHKAN

  User(super.id, this.email, this.firstName, this.lastName,
      {this.role = 'client'});

  String get name => "$firstName $lastName";

  // Method pembantu untuk mengecek apakah user adalah admin
  bool isAdmin() => this.role == 'admin';

  // Method untuk konversi ke JSON (penting untuk LocalStorage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
    };
  }

  // Factory constructor untuk membuat User dari JSON (penting untuk LocalStorage)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] ?? -1,
      json['email'] ?? '',
      json['firstName'] ?? '',
      json['lastName'] ?? '',
      role: json['role'] ?? 'client',
    );
  }
}
