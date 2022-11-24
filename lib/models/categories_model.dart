import 'dart:convert';

List<CategoryModel> categoryFromJson(String str) => List<CategoryModel>.from(
    json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel({
    this.id,
    this.count,
    this.name,
  });

  int? id;
  int? count;
  String? name;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        count: json["count"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "name": name,
      };
}
