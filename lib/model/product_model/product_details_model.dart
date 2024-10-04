import 'dart:convert';
ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));
String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());
class ProductDetailsModel {
  ProductDetailsModel({
      this.data, 
      this.message, 
      this.status,});

  ProductDetailsModel.fromJson(dynamic json) {
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
      this.product, 
      this.productAttachments, 
      this.attributesOptions, 
      this.productAttributes,});

  Data.fromJson(dynamic json) {
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['product_attachments'] != null) {
      productAttachments = [];
      json['product_attachments'].forEach((v) {
        productAttachments?.add(ProductAttachments.fromJson(v));
      });
    }
    if (json['attributes_options'] != null) {
      attributesOptions = [];
      json['attributes_options'].forEach((v) {
        attributesOptions?.add(AttributesOptions.fromJson(v));
      });
    }
    if (json['product_attributes'] != null) {
      productAttributes = [];
      json['product_attributes'].forEach((v) {
        productAttributes?.add(ProductAttributes.fromJson(v));
      });
    }
  }
  Product? product;
  List<ProductAttachments>? productAttachments;
  List<AttributesOptions>? attributesOptions;
  List<ProductAttributes>? productAttributes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (product != null) {
      map['product'] = product?.toJson();
    }
    if (productAttachments != null) {
      map['product_attachments'] = productAttachments?.map((v) => v.toJson()).toList();
    }
    if (attributesOptions != null) {
      map['attributes_options'] = attributesOptions?.map((v) => v.toJson()).toList();
    }
    if (productAttributes != null) {
      map['product_attributes'] = productAttributes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

ProductAttributes productAttributesFromJson(String str) => ProductAttributes.fromJson(json.decode(str));
String productAttributesToJson(ProductAttributes data) => json.encode(data.toJson());
class ProductAttributes {
  ProductAttributes({
      this.id, 
      this.attributeName,});

  ProductAttributes.fromJson(dynamic json) {
    id = json['id'];
    attributeName = json['attribute_name'];
  }
  int? id;
  String? attributeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['attribute_name'] = attributeName;
    return map;
  }

}

AttributesOptions attributesOptionsFromJson(String str) => AttributesOptions.fromJson(json.decode(str));
String attributesOptionsToJson(AttributesOptions data) => json.encode(data.toJson());
class AttributesOptions {
  AttributesOptions({
      this.attributeId, 
      this.values,});

  AttributesOptions.fromJson(dynamic json) {
    attributeId = json['attribute_id'];
    values = json['values'] != null ? json['values'].cast<String>() : [];
  }
  String? attributeId;
  List<String>? values;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attribute_id'] = attributeId;
    map['values'] = values;
    return map;
  }

}

ProductAttachments productAttachmentsFromJson(String str) => ProductAttachments.fromJson(json.decode(str));
String productAttachmentsToJson(ProductAttachments data) => json.encode(data.toJson());
class ProductAttachments {
  ProductAttachments({
      this.attachment,});

  ProductAttachments.fromJson(dynamic json) {
    attachment = json['attachment'];
  }
  String? attachment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attachment'] = attachment;
    return map;
  }

}

Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toJson());
class Product {
  Product({
      this.attachment, 
      this.id, 
      this.productName, 
      this.description,
      this.unitPrice,
      this.rating, 
      this.gallery, 
      this.attributesOptions,});

  Product.fromJson(dynamic json) {
    attachment = json['attachment'];
    id = json['id'];
    productName = json['product_name'];
    description = json['description'];
    unitPrice = json['unit_price'];
    rating = json['rating'];
    gallery = json['gallery'];
    attributesOptions = json['attributes_options'];
  }
  String? attachment;
  int? id;
  String? productName;
  String? description;
  int? unitPrice;
  int? rating;
  String? gallery;
  String? attributesOptions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attachment'] = attachment;
    map['id'] = id;
    map['product_name'] = productName;
    map['description'] = description;
    map['unit_price'] = unitPrice;
    map['rating'] = rating;
    map['gallery'] = gallery;
    map['attributes_options'] = attributesOptions;
    return map;
  }

}