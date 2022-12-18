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
    required this.productId,
    required this.created,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
  });

  int productId;
  DateTime created;
  String name;
  String image;
  int quantity;
  double price;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        productId: json["productId"],
        created: DateTime.parse(json["_created"]),
        name: json["name"],
        image: json["image"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "_created": created.toIso8601String(),
        "name": name,
        "image": image,
        "quantity": quantity,
        "price": price,
      };
}
