import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../presentation/resources/string_manager.dart';

class AppUser {
  final String id;
  String? password;
  String? email;
  String? photoUrl;
  String? name;
  String? phoneNumber;
  String? secondPhoneNumber;
  String? nationalId;
  double? age;
  List<String>? postsId;
  List<Position>? places;
  bool panned = false;

  String get subscribeId => id.replaceAll("+", "");

  @override
  String toString() {
    return "User $name with email $email";
  }

  AppUser(
      {required this.id,
      this.name,
      this.panned = false,
      this.email,
      this.photoUrl,
      this.phoneNumber,
      this.age,
      this.password,
      this.nationalId,
      this.places,
      this.postsId,
      this.secondPhoneNumber});

  bool get isComplete => postsId != null;

  Map<String, dynamic> get toJson => {
        "id": id,
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "phoneNumber": phoneNumber,
        "secondPhoneNumber": secondPhoneNumber,
        "age": age,
        "nationalId": nationalId,
        "postsId": postsId,
        "password": password,
        "places": places?.map((e) => e.toJson()),
      };

  factory AppUser.fromJson(dynamic jsonData) {
    jsonData = jsonData is String ? json.decode(jsonData) : jsonData;
    return AppUser(
      panned: jsonData['panned'] ?? false,
      id: jsonData['id'],
      password: jsonData['password'],
      name: jsonData["name"],
      email: jsonData["email"],
      photoUrl: jsonData["photoUrl"],
      phoneNumber: jsonData['phoneNumber'],
      secondPhoneNumber: jsonData['secondPhoneNumber'],
      age: jsonData['age'],
      nationalId: jsonData['nationalId'],
      places: jsonData['places']?.map((e) => Position.fromMap(e)),
      postsId: jsonData['postsId'] == null
          ? []
          : List<String>.from(jsonData['postsId']),
    );
  }

  factory AppUser.fromFirebaseUser(
    User? user,
  ) =>
      user == null
          ? AppUser.empty()
          : AppUser(
              id: user.phoneNumber ?? user.uid,
              email: user.email,
              photoUrl: user.photoURL,
              name: user.displayName,
            );

  factory AppUser.empty() => AppUser(id: '');

  bool get isEmpty => id == '';
}

enum Gender {
  male,
  female;

  @override
  String toString() {
    switch (this) {
      case Gender.male:
        return StringManger.male;
      case Gender.female:
        return StringManger.female;
    }
  }

  IconData toIcon() {
    switch (this) {
      case Gender.male:
        return Icons.male;
      case Gender.female:
        return Icons.female;
    }
  }
}
