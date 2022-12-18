// To parse this JSON data, do
//
//     final orderItem = orderItemFromJson(jsonString);

import 'dart:convert';

List<OrderItem> orderItemFromJson(String str) =>
    List<OrderItem>.from(json.decode(str).map((x) => OrderItem.fromJson(x)));

String orderItemToJson(List<OrderItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderItem {
  OrderItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.quantity,
    required this.creator,
    required this.updater,
    required this.product,
    required this.order,
  });

  int id;
  String name;
  String image;
  double price;
  DateTime created;
  DateTime updated;
  dynamic deleted;
  int quantity;
  int creator;
  int updater;
  int product;
  int order;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        created: DateTime.parse(json["_created"]),
        updated: DateTime.parse(json["_updated"]),
        deleted: json["_deleted"],
        quantity: json["quantity"],
        creator: json["_creator"],
        updater: json["_updater"],
        product: json["product"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "_created": created.toIso8601String(),
        "_updated": updated.toIso8601String(),
        "_deleted": deleted,
        "quantity": quantity,
        "_creator": creator,
        "_updater": updater,
        "product": product,
        "order": order,
      };
}
