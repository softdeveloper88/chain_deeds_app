import 'dart:convert';
BlogCategoryModel blogCategoryModelFromJson(String str) => BlogCategoryModel.fromJson(json.decode(str));
String blogCategoryModelToJson(BlogCategoryModel data) => json.encode(data.toJson());
class BlogCategoryModel {
  BlogCategoryModel({
      this.data, 
      this.message, 
      this.status,});

  BlogCategoryModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  List<Data>? data;
  String? message;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.id, 
      this.categoryName,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    categoryName = json['category_name'];
  }
  int? id;
  String? categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_name'] = categoryName;
    return map;
  }

}