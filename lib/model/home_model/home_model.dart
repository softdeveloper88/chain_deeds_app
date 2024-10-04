import 'dart:convert';
HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));
String homeModelToJson(HomeModel data) => json.encode(data.toJson());
class HomeModel {
  HomeModel({
      this.data, 
      this.message, 
      this.status,});

  HomeModel.fromJson(dynamic json) {
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
      this.donatedTotal, 
      this.fundTotal, 
      this.chainNumber, 
      this.products, 
      this.blogs, 
      this.campaigns,});

  Data.fromJson(dynamic json) {
    donatedTotal = json['donated_total'];
    fundTotal = json['fund_total'];
    chainNumber = json['chain_number'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    if (json['blogs'] != null) {
      blogs = [];
      json['blogs'].forEach((v) {
        blogs?.add(Blogs.fromJson(v));
      });
    }
    if (json['campaigns'] != null) {
      campaigns = [];
      json['campaigns'].forEach((v) {
        campaigns?.add(Campaigns.fromJson(v));
      });
    }
  }
  String? donatedTotal;
  String? fundTotal;
  int? chainNumber;
  List<Products>? products;
  List<Blogs>? blogs;
  List<Campaigns>? campaigns;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['donated_total'] = donatedTotal;
    map['fund_total'] = fundTotal;
    map['chain_number'] = chainNumber;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    if (blogs != null) {
      map['blogs'] = blogs?.map((v) => v.toJson()).toList();
    }
    if (campaigns != null) {
      map['campaigns'] = campaigns?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Campaigns campaignsFromJson(String str) => Campaigns.fromJson(json.decode(str));
String campaignsToJson(Campaigns data) => json.encode(data.toJson());
class Campaigns {
  Campaigns({
      this.thumbnail, 
      this.id, 
      this.title, 
      this.shortDescription, 
      this.targetSupporters, 
      this.displayStatus, 
      this.bg, 
      this.imgPosition, 
      this.createdAt, 
      this.percentage,
      this.likes,
     this.isLike=0,
      this.unlikes,});

  Campaigns.fromJson(dynamic json) {
    thumbnail = json['thumbnail'];
    id = json['id'];
    title = json['title'];
    shortDescription = json['short_description'];
    targetSupporters = json['target_supporters'];
    displayStatus = json['display_status'];
    bg = json['bg'];
    imgPosition = json['img_position'];
    createdAt = json['created_at'];
    percentage = json['percentage'];
    likes = json['likes'];
    unlikes = json['unlikes'];
  }
  String? thumbnail;
  int? id;
  String? title;
  String? shortDescription;
  String? targetSupporters;
  String? displayStatus;
  String? percentage;
  String? bg;
  String? imgPosition;
  String? createdAt;
  int? likes;
  int? unlikes;
  int? isLike;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['thumbnail'] = thumbnail;
    map['id'] = id;
    map['title'] = title;
    map['short_description'] = shortDescription;
    map['target_supporters'] = targetSupporters;
    map['display_status'] = displayStatus;
    map['bg'] = bg;
    map['img_position'] = imgPosition;
    map['created_at'] = createdAt;
    map['likes'] = likes;
    map['unlikes'] = unlikes;
    return map;
  }

}

Blogs blogsFromJson(String str) => Blogs.fromJson(json.decode(str));
String blogsToJson(Blogs data) => json.encode(data.toJson());
class Blogs {
  Blogs({
      this.thumbnail, 
      this.categoryName, 
      this.id, 
      this.thumbnailType, 
      this.title, 
      this.subTitle, 
      this.createdAt, 
      this.likes, 
      this.unlikes,});

  Blogs.fromJson(dynamic json) {
    thumbnail = json['thumbnail'];
    categoryName = json['category_name'];
    id = json['id'];
    thumbnailType = json['thumbnail_type'];
    title = json['title'];
    subTitle = json['sub_title'];
    createdAt = json['created_at'];
    likes = json['likes'];
    unlikes = json['unlikes'];
  }
  String? thumbnail;
  String? categoryName;
  int? id;
  String? thumbnailType;
  String? title;
  String? subTitle;
  String? createdAt;
  int? likes;
  int? unlikes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['thumbnail'] = thumbnail;
    map['category_name'] = categoryName;
    map['id'] = id;
    map['thumbnail_type'] = thumbnailType;
    map['title'] = title;
    map['sub_title'] = subTitle;
    map['created_at'] = createdAt;
    map['likes'] = likes;
    map['unlikes'] = unlikes;
    return map;
  }

}

Products productsFromJson(String str) => Products.fromJson(json.decode(str));
String productsToJson(Products data) => json.encode(data.toJson());
class Products {
  Products({
      this.id, 
      this.productName, 
      this.unitPrice, 
      this.thumbnail,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    productName = json['product_name'];
    unitPrice = json['unit_price'];
    thumbnail = json['thumbnail'];
  }
  int? id;
  String? productName;
  int? unitPrice;
  String? thumbnail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_name'] = productName;
    map['unit_price'] = unitPrice;
    map['thumbnail'] = thumbnail;
    return map;
  }

}