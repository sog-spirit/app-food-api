// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    required this.id,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.name,
    required this.description,
    required this.image,
    required this.creator,
    required this.updater,
  });

  int id;
  DateTime created;
  DateTime updated;
  dynamic deleted;
  String name;
  String description;
  String image;
  int creator;
  int updater;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        created: DateTime.parse(json["_created"]),
        updated: DateTime.parse(json["_updated"]),
        deleted: json["_deleted"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        creator: json["_creator"],
        updater: json["_updater"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "_created": created.toIso8601String(),
        "_updated": updated.toIso8601String(),
        "_deleted": deleted,
        "name": name,
        "description": description,
        "image": image,
        "_creator": creator,
        "_updater": updater,
      };
}
