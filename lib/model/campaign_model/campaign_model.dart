import 'dart:convert';

import '../home_model/home_model.dart';
CampaignModel campaignModelFromJson(String str) => CampaignModel.fromJson(json.decode(str));
String campaignModelToJson(CampaignModel data) => json.encode(data.toJson());
class CampaignModel {
  CampaignModel({
      this.data, 
      this.message, 
      this.status,});

  CampaignModel.fromJson(dynamic json) {
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
  Data({this.campaigns,});

  Data.fromJson(dynamic json) {
    if (json['campaigns'] != null) {
      campaigns = [];
      json['campaigns'].forEach((v) {
        campaigns?.add(Campaigns.fromJson(v));
      });
    }
  }
  List<Campaigns>? campaigns;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (campaigns != null) {
      map['campaigns'] = campaigns?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

