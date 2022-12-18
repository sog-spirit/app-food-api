// To parse this JSON data, do
//
//     final productOrder = productOrderFromJson(jsonString);

import 'dart:convert';

List<ProductOrder> productOrderFromJson(String str) => List<ProductOrder>.from(json.decode(str).map((x) => ProductOrder.fromJson(x)));

String productOrderToJson(List<ProductOrder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductOrder {
    ProductOrder({
       required this.product,
       required this.quantity,
    });

    int product;
    int quantity;

    factory ProductOrder.fromJson(Map<String, dynamic> json) => ProductOrder(
        product: json["product"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
    };
}
