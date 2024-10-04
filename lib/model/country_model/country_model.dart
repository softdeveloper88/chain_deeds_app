import 'dart:convert';
CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));
String countryModelToJson(CountryModel data) => json.encode(data.toJson());
class CountryModel {
  CountryModel({
      this.data, 
      this.message, 
      this.status,});

  CountryModel.fromJson(dynamic json) {
    data = json['data'] != null ? CountryData.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }
  CountryData? data;
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

CountryData dataFromJson(String str) => CountryData.fromJson(json.decode(str));
String dataToJson(CountryData data) => json.encode(data.toJson());
class CountryData {
  CountryData({
      this.countries,});

  CountryData.fromJson(dynamic json) {
    if (json['countries'] != null) {
      countries = [];
      json['countries'].forEach((v) {
        countries?.add(Countries.fromJson(v));
      });
    }
  }
  List<Countries>? countries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (countries != null) {
      map['countries'] = countries?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Countries countriesFromJson(String str) => Countries.fromJson(json.decode(str));
String countriesToJson(Countries data) => json.encode(data.toJson());
class Countries {
  Countries({
      this.id, 
      this.name,});

  Countries.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}