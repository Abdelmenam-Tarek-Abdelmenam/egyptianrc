import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  String id;
  String? password;
  String? email;
  String? photoUrl;
  String? name;
  String? phoneNumber;
  String? secondPhoneNumber;
  Map<String, String>? postsId;
  List<String>? places;
  bool panned = false;
  bool seen = false;

  String get subscribeId => id.replaceAll("+", "");
  String get firstPlace => places?.isEmpty ?? true ? "" : places?.first ?? "";
  String get secondPlace => (places?.length ?? 0) < 1 ? "" : places![1];
  String get thirdPlace => (places?.length ?? 0) < 2 ? "" : places![2];

  @override
  String toString() {
    return "User $name with email $email";
  }

  AppUser(
      {required this.id,
      this.name,
      this.panned = false,
      this.seen = false,
      this.email,
      this.photoUrl,
      this.phoneNumber,
      this.password,
      this.places,
      this.postsId,
      this.secondPhoneNumber});

  AppUser copyWith(
      {String? password,
      String? email,
      String? photoUrl,
      String? name,
      String? phoneNumber,
      String? secondPhoneNumber,
      List<String>? places}) {
    return AppUser(
      panned: panned,
      seen: seen,
      id: id,
      password: password ?? this.password,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      secondPhoneNumber: secondPhoneNumber ?? this.secondPhoneNumber,
      places: places ?? this.places,
      postsId: postsId,
    );
  }

  bool get isComplete => postsId != null;

  Map<String, dynamic> get toJson => {
        "id": id,
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "phoneNumber": phoneNumber,
        "secondPhoneNumber": secondPhoneNumber,
        "postsId": postsId,
        "password": password,
        "places": places ?? [],
      };

  factory AppUser.fromJson(dynamic jsonData, {bool seen = false}) {
    jsonData = jsonData is String ? json.decode(jsonData) : jsonData;
    return AppUser(
      panned: jsonData['panned'] ?? false,
      seen: seen,
      id: jsonData['id'],
      password: jsonData['password'],
      name: jsonData["name"],
      email: jsonData["email"],
      photoUrl: jsonData["photoUrl"],
      phoneNumber: jsonData['phoneNumber'],
      secondPhoneNumber: jsonData['secondPhoneNumber'],
      places: jsonData['places'] == null
          ? []
          : List<String>.from(jsonData['places']),
      postsId: jsonData['postsId'] == null
          ? {}
          : Map<String, String>.from(jsonData['postsId']),
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
