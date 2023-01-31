import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String id;
  final String? email;
  final String? photoUrl;
  String? name;

  @override
  String toString() {
    return "User $name with email $email";
  }

  AppUser({required this.id, this.name, this.email, this.photoUrl});

  Map<String, dynamic> get toJson => {
        "id": id,
        "email": email,
        "photoUrl": photoUrl,
        "name": name,
      };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json['id'],
        email: json["email"],
        photoUrl: json["photoUrl"],
        name: json["name"],
      );

  factory AppUser.fromFirebaseUser(
    User? user,
  ) =>
      user == null
          ? AppUser.empty()
          : AppUser(
              id: user.uid,
              email: user.email,
              photoUrl: user.photoURL,
              name: user.displayName,
            );

  factory AppUser.empty() => AppUser(
        id: '',
      );

  bool get isEmpty => id == '';
}

class CompleteUser {
  AppUser user;
  List<String>? orders;

  CompleteUser({required this.user, this.orders, String? userName});

  Map<String, dynamic> get toJson => {...user.toJson, "orders": orders};

  factory CompleteUser.fromJson(dynamic jsonData) {
    jsonData = jsonData is String ? json.decode(jsonData) : jsonData;
    return CompleteUser(
        orders: List<String>.from(jsonData["orders"]),
        user: AppUser.fromJson(jsonData));
  }

  factory CompleteUser.inComplete(AppUser user) => CompleteUser(user: user);

  bool get isComplete => orders != null;
}
