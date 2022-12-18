// To parse required this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  var value;

  Product({
    required this.id,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.quantity,
    required this.creator,
    required this.updater,
    required this.category,
    required status,
  });

  final int id;
  DateTime created;
  DateTime updated;
  dynamic deleted;
  String name;
  String image;
  double price;
  String description;
  int quantity;
  Status? status;
  int creator;
  int updater;
  int category;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        created: DateTime.parse(json["_created"]),
        updated: DateTime.parse(json["_updated"]),
        deleted: json["_deleted"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        description: json["description"],
        quantity: json["quantity"],
        status: statusValues.map[json["status"]],
        creator: json["_creator"],
        updater: json["_updater"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "_created": created.toIso8601String(),
        "_updated": updated.toIso8601String(),
        "_deleted": deleted,
        "name": name,
        "image": image,
        "price": price,
        "description": description,
        "quantity": quantity,
        "status": statusValues.reverse[status],
        "_creator": creator,
        "_updater": updater,
        "category": category,
      };
}

enum Status { E }

final statusValues = EnumValues({"E": Status.E});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
