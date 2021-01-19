// To parse this JSON data, do
//
//     final matchUser = matchUserFromMap(jsonString);

import 'dart:convert';

class MatchUser {
  MatchUser({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.age,
    this.sex,
    this.emoji1,
    this.emoji2,
    this.emoji3,
    this.emoji4,
    this.profilePhotoPath,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoUrl,
  });

  final int id;
  final String name;
  final String email;
  final DateTime emailVerifiedAt;
  final int age;
  final String sex;
  final String emoji1;
  final String emoji2;
  final String emoji3;
  final String emoji4;
  final String profilePhotoPath;
  final String deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String profilePhotoUrl;

  factory MatchUser.fromJson(String str) => MatchUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MatchUser.fromMap(Map<String, dynamic> json) => MatchUser(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    age: json["age"] == null ? null : json["age"],
    sex: json["sex"] == null ? null : json["sex"],
    emoji1: json["emoji_1"] == null ? null : json["emoji_1"],
    emoji2: json["emoji_2"] == null ? null : json["emoji_2"],
    emoji3: json["emoji_3"] == null ? null : json["emoji_3"],
    emoji4: json["emoji_4"] == null ? null : json["emoji_4"],
    profilePhotoPath: json["profile_photo_path"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    profilePhotoUrl: json["profile_photo_url"] == null ? null : json["profile_photo_url"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "email_verified_at": emailVerifiedAt == null ? null : emailVerifiedAt.toIso8601String(),
    "age": age == null ? null : age,
    "sex": sex == null ? null : sex,
    "emoji_1": emoji1 == null ? null : emoji1,
    "emoji_2": emoji2 == null ? null : emoji2,
    "emoji_3": emoji3 == null ? null : emoji3,
    "emoji_4": emoji4 == null ? null : emoji4,
    "profile_photo_path": profilePhotoPath,
    "deleted_at": deletedAt,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "profile_photo_url": profilePhotoUrl == null ? null : profilePhotoUrl,
  };
}
