// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  Cart({
    required this.id,
    required this.name,
    required this.image,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.quantity,
    required this.creator,
    required this.updater,
    required this.product,
    required this.price,
  });

  int id;
  String name;
  String image;
  DateTime created;
  DateTime updated;
  dynamic deleted;
  int quantity;
  int creator;
  int updater;
  int product;
  int price;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        created: DateTime.parse(json["_created"]),
        updated: DateTime.parse(json["_updated"]),
        deleted: json["_deleted"],
        quantity: json["quantity"],
        creator: json["_creator"],
        updater: json["_updater"],
        product: json["product"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "_created": created.toIso8601String(),
        "_updated": updated.toIso8601String(),
        "_deleted": deleted,
        "quantity": quantity,
        "_creator": creator,
        "_updater": updater,
        "product": product,
        "price": price,
      };
}
