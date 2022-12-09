// To parse this JSON data, do
//
//     final clientesJson = clientesJsonFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ClientesJson clientesJsonFromJson(String str) => ClientesJson.fromJson(json.decode(str));

String clientesJsonToJson(ClientesJson data) => json.encode(data.toJson());

class ClientesJson {
  ClientesJson({
    required this.ok,
    required this.msg,
    required this.data,
    required this.info,
  });

  bool ok;
  String msg;
  List<Datum> data;
  Info info;

  factory ClientesJson.fromJson(Map<String, dynamic> json) => ClientesJson(
    ok: json["ok"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    info: Info.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "info": info.toJson(),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.region,
    required this.postalCode,
    required this.countryCode,
    required this.note,
    required this.customerCode,
    required this.firstVisit,
    required this.lastVisit,
    required this.totalVisits,
    required this.totalSpent,
    required this.totalPoints,
    required this.permanentDeletionAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  String id;
  String name;
  String email;
  String phoneNumber;
  String address;
  String city;
  dynamic region;
  String postalCode;
  String countryCode;
  String note;
  String customerCode;
  DateTime firstVisit;
  DateTime lastVisit;
  int totalVisits;
  int totalSpent;
  int totalPoints;
  dynamic permanentDeletionAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"] == null ? "Sin nombre" : json["name"],
    email: json["email"] == null ? "sinmail@sinmail.com" : json["email"],
    phoneNumber: json["phone_number"] == null ? "1234567890" : json["phone_number"],
    address: json["address"] == null ? "sin direccion" : json["address"],
    city: json["city"] == null ? "sin ciudad" : json["city"],
    region: json["region"] == null ? "sin region" : json["region"],
    postalCode: json["postal_code"] == null ? "0000" : json["postal_code"],
    countryCode: json["country_code"] == null ? "CL" : json["country_code"],
    note: json["note"] == null ? "" : json["note"],
    customerCode: json["customer_code"] == null ? "000" : json["customer_code"],
    firstVisit: json["first_visit"] == null ? DateTime.now() : DateTime.parse(json["first_visit"]),
    lastVisit: json["last_visit"] == null ? DateTime.now() : DateTime.parse(json["last_visit"]),
    totalVisits: json["total_visits"] == null ? "0" : json["total_visits"],
    totalSpent: json["total_spent"] == null ? "0" : json["total_spent"],
    totalPoints: json["total_points"] == null ? "0" : json["total_points"],
    permanentDeletionAt: json["permanent_deletion_at"] == null ? "" : json["permanent_deletion_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? "" : json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "address": address == null ? null : address,
    "city": city == null ? null : city,
    "region": region == null ? null : region,
    "postal_code": postalCode == null ? null : postalCode,
    "country_code": countryCode == null ? null : countryCode,
    "note": note == null ? null : note,
    "customer_code": customerCode == null ? null : customerCode,
    "first_visit": firstVisit == null ? null : firstVisit.toIso8601String(),
    "last_visit": lastVisit == null ? null : lastVisit.toIso8601String(),
    "total_visits": totalVisits == null ? null : totalVisits,
    "total_spent": totalSpent == null ? null : totalSpent,
    "total_points": totalPoints == null ? null : totalPoints,
    "permanent_deletion_at": permanentDeletionAt == null ? null : permanentDeletionAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt == null ? null : deletedAt,
  };
}

class Info {
  Info();

  factory Info.fromJson(Map<String, dynamic> json) => Info(
  );

  Map<String, dynamic> toJson() => {
  };
}
