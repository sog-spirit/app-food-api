// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    required this.id,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.price,
    required this.paymentMethod,
    required this.orderStatus,
    required this.address,
    required this.note,
    required this.creator,
    required this.updater,
    required this.user,
  });

  int id;
  DateTime created;
  DateTime updated;
  dynamic deleted;
  double price;
  String paymentMethod;
  String orderStatus;
  String address;
  String note;
  int creator;
  int updater;
  int user;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        created: DateTime.parse(json["_created"]),
        updated: DateTime.parse(json["_updated"]),
        deleted: json["_deleted"],
        price: json["price"],
        paymentMethod: json["payment_method"],
        orderStatus: json["order_status"],
        address: json["address"],
        note: json["note"],
        creator: json["_creator"],
        updater: json["_updater"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "_created": created.toIso8601String(),
        "_updated": updated.toIso8601String(),
        "_deleted": deleted,
        "price": price,
        "payment_method": paymentMethod,
        "order_status": orderStatus,
        "address": address,
        "note": note,
        "_creator": creator,
        "_updater": updater,
        "user": user,
      };
}
