// To parse this JSON data, do
//
//     final match = matchFromMap(jsonString);

import 'dart:convert';

import 'package:tinji/models/user.dart';

class TinjiMatch {
  TinjiMatch({
    this.id,
    this.host,
    this.client,
    this.lastMessage,
  });

  final int id;
  final User host;
  final User client;
  final LastMessage lastMessage;

  factory TinjiMatch.fromJson(String str) => TinjiMatch.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TinjiMatch.fromMap(Map<String, dynamic> json) => TinjiMatch(
    id: json["id"] == null ? null : json["id"],
    host: json["host"] == null ? null : User.fromMap(json["host"]),
    client: json["client"] == null ? null : User.fromMap(json["client"]),
    lastMessage: json["last_message"] == null ? null : LastMessage.fromMap(json["last_message"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "host": host == null ? null : host.toMap(),
    "client": client == null ? null : client.toMap(),
    "last_message": lastMessage == null ? null : lastMessage.toMap(),
  };
}


class LastMessage {
  LastMessage({
    this.id,
    this.matchId,
    this.fromId,
    this.message,
    this.seen,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int matchId;
  final int fromId;
  final String message;
  final int seen;
  final dynamic deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory LastMessage.fromJson(String str) => LastMessage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LastMessage.fromMap(Map<String, dynamic> json) => LastMessage(
    id: json["id"] == null ? null : json["id"],
    matchId: json["match_id"] == null ? null : json["match_id"],
    fromId: json["from_id"] == null ? null : json["from_id"],
    message: json["message"] == null ? null : json["message"],
    seen: json["seen"] == null ? null : json["seen"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "match_id": matchId == null ? null : matchId,
    "from_id": fromId == null ? null : fromId,
    "message": message == null ? null : message,
    "seen": seen == null ? null : seen,
    "deleted_at": deletedAt,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
