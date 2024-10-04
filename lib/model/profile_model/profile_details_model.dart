import 'dart:convert';
ProfileDetailsModel profileDetailsModelFromJson(String str) => ProfileDetailsModel.fromJson(json.decode(str));
String profileDetailsModelToJson(ProfileDetailsModel data) => json.encode(data.toJson());
class ProfileDetailsModel {
  ProfileDetailsModel({
      this.data, 
      this.message, 
      this.status,});

  ProfileDetailsModel.fromJson(dynamic json) {
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
      this.user,});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.phone, 
      this.dialCode, 
      this.countryCode, 
      this.dob, 
      this.country, 
      this.gender, 
      this.address, 
      this.profession, 
      this.placeOfWorship,});

  User.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    dialCode = json['dial_code'];
    countryCode = json['country_code'];
    dob = json['dob'];
    country = json['country'];
    gender = json['gender'];
    address = json['address'];
    profession = json['profession'];
    placeOfWorship = json['place_of_worship'];
  }
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? dialCode;
  String? countryCode;
  dynamic dob;
  dynamic country;
  dynamic gender;
  dynamic address;
  dynamic profession;
  dynamic placeOfWorship;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone'] = phone;
    map['dial_code'] = dialCode;
    map['country_code'] = countryCode;
    map['dob'] = dob;
    map['country'] = country;
    map['gender'] = gender;
    map['address'] = address;
    map['profession'] = profession;
    map['place_of_worship'] = placeOfWorship;
    return map;
  }

}