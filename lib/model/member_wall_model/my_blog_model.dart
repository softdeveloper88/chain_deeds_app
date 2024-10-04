import 'dart:convert';
MyBlogModel myBlogModelFromJson(String str) => MyBlogModel.fromJson(json.decode(str));
String myBlogModelToJson(MyBlogModel data) => json.encode(data.toJson());
class MyBlogModel {
  MyBlogModel({
      this.id, 
      this.userId, 
      this.categoryId, 
      this.title, 
      this.subTitle, 
      this.thumbnail, 
      this.thumbnailType, 
      this.description, 
      this.views, 
      this.status, 
      this.isRequested, 
      this.isDisplayInMw, 
      this.createdAt, 
      this.updatedAt,});

  MyBlogModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    thumbnail = json['thumbnail'];
    thumbnailType = json['thumbnail_type'];
    description = json['description'];
    views = json['views'];
    status = json['status'];
    isRequested = json['is_requested'];
    isDisplayInMw = json['is_display_in_mw'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userId;
  int? categoryId;
  String? title;
  String? subTitle;
  String? thumbnail;
  String? thumbnailType;
  String? description;
  int? views;
  int? status;
  int? isRequested;
  int? isDisplayInMw;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['category_id'] = categoryId;
    map['title'] = title;
    map['sub_title'] = subTitle;
    map['thumbnail'] = thumbnail;
    map['thumbnail_type'] = thumbnailType;
    map['description'] = description;
    map['views'] = views;
    map['status'] = status;
    map['is_requested'] = isRequested;
    map['is_display_in_mw'] = isDisplayInMw;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}