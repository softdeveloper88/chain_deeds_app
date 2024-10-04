import 'dart:convert';
GetMemberModel getMemberModelFromJson(String str) => GetMemberModel.fromJson(json.decode(str));
String getMemberModelToJson(GetMemberModel data) => json.encode(data.toJson());
class GetMemberModel {
  GetMemberModel({
      this.data, 
      this.message, 
      this.status,});

  GetMemberModel.fromJson(dynamic json) {
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
      this.members,});

  Data.fromJson(dynamic json) {
    if (json['members'] != null) {
      members = [];
      json['members'].forEach((v) {
        members?.add(Members.fromJson(v));
      });
    }
  }
  List<Members>? members;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (members != null) {
      map['members'] = members?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Members membersFromJson(String str) => Members.fromJson(json.decode(str));
String membersToJson(Members data) => json.encode(data.toJson());
class Members {
  Members({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.relation,});

  Members.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    relation = json['relation'];
  }
  int? id;
  String? name;
  String? email;
  String? phone;
  String? relation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['relation'] = relation;
    return map;
  }

}