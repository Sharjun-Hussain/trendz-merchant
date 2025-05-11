// To parse this JSON data, do
//
//     final services = servicesFromJson(jsonString);

import 'dart:convert';

Services servicesFromJson(String str) => Services.fromJson(json.decode(str));

String servicesToJson(Services data) => json.encode(data.toJson());

class Services {
  List<Datum> data;

  Services({
    required this.data,
  });

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? saloonId;
  String code;
  String name;
  String icon;
  String description;
  String price;
  int duration;
  int status;
  int? deleteStatus;

  Datum({
    this.id,
    this.saloonId,
    required this.code,
    required this.name,
    required this.icon,
    required this.description,
    required this.price,
    required this.duration,
    required this.status,
    this.deleteStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        saloonId: json["saloon_id"],
        code: json["code"],
        name: json["name"],
        icon: json["icon"],
        description: json["description"],
        price: json["price"],
        duration: json["duration"],
        status: json["status"],
        deleteStatus: json["delete_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "saloon_id": saloonId,
        "code": code,
        "name": name,
        "icon": icon,
        "description": description,
        "price": price,
        "duration": duration,
        "status": status,
        "delete_status": deleteStatus,
      };
}
