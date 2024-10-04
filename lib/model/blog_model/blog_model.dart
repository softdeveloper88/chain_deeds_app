import 'dart:convert';
BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));
String blogModelToJson(BlogModel data) => json.encode(data.toJson());
class BlogModel {
  BlogModel({
      this.data, 
      this.message, 
      this.status,});

  BlogModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }
  Data? data;
  String? message;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
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
      this.blogs,});

  Data.fromJson(dynamic json) {
    if (json['blogs'] != null) {
      blogs = [];
      json['blogs'].forEach((v) {
        blogs?.add(Blogs.fromJson(v));
      });
    }
  }
  List<Blogs>? blogs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (blogs != null) {
      map['blogs'] = blogs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Blogs blogsFromJson(String str) => Blogs.fromJson(json.decode(str));
String blogsToJson(Blogs data) => json.encode(data.toJson());
class Blogs {
  Blogs({
      this.id, 
      this.thumbnail, 
      this.thumbnailType, 
      this.title, 
      this.categoryName, 
      this.subTitle, 
      this.createdAt,});

  Blogs.fromJson(dynamic json) {
    id = json['id'];
    thumbnail = json['thumbnail'];
    thumbnailType = json['thumbnail_type'];
    title = json['title'];
    categoryName = json['category_name'];
    subTitle = json['sub_title'];
    createdAt = json['created_at'];
  }
  int? id;
  String? thumbnail;
  String? thumbnailType;
  String? title;
  String? categoryName;
  String? subTitle;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['thumbnail'] = thumbnail;
    map['thumbnail_type'] = thumbnailType;
    map['title'] = title;
    map['category_name'] = categoryName;
    map['sub_title'] = subTitle;
    map['created_at'] = createdAt;
    return map;
  }

}