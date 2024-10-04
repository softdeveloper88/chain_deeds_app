import 'dart:convert';
CodTokenModel codTokenModelFromJson(String str) => CodTokenModel.fromJson(json.decode(str));
String codTokenModelToJson(CodTokenModel data) => json.encode(data.toJson());
class CodTokenModel {
  CodTokenModel({
      this.data, 
      this.message, 
      this.status,});

  CodTokenModel.fromJson(dynamic json) {
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
      this.tokenAvailable, 
      this.syncedContacts, 
      this.tokensPurchased, 
      this.tokensSpent, 
      this.monthlyTokens, 
      this.transactions,});

  Data.fromJson(dynamic json) {
    tokenAvailable = json['token_available'];
    syncedContacts = json['synced_contacts'];
    tokensPurchased = json['tokens_purchased'];
    tokensSpent = json['tokens_spent'];
    monthlyTokens = json['monthly_tokens'];
    if (json['transactions'] != null) {
      transactions = [];
      json['transactions'].forEach((v) {
        transactions?.add(Transactions.fromJson(v));
      });
    }
  }
  int? tokenAvailable;
  int? syncedContacts;
  int? tokensPurchased;
  String? tokensSpent;
  String? monthlyTokens;
  List<Transactions>? transactions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token_available'] = tokenAvailable;
    map['synced_contacts'] = syncedContacts;
    map['tokens_purchased'] = tokensPurchased;
    map['tokens_spent'] = tokensSpent;
    map['monthly_tokens'] = monthlyTokens;
    if (transactions != null) {
      map['transactions'] = transactions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Transactions transactionsFromJson(String str) => Transactions.fromJson(json.decode(str));
String transactionsToJson(Transactions data) => json.encode(data.toJson());
class Transactions {
  Transactions({
      this.id, 
      this.tokens, 
      this.createdAt, 
      this.userName, 
      this.memberName,});

  Transactions.fromJson(dynamic json) {
    id = json['id'];
    tokens = json['tokens'];
    createdAt = json['created_at'];
    userName = json['user_name'];
    memberName = json['member_name'];
  }
  int? id;
  int? tokens;
  String? createdAt;
  String? userName;
  dynamic memberName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['tokens'] = tokens;
    map['created_at'] = createdAt;
    map['user_name'] = userName;
    map['member_name'] = memberName;
    return map;
  }

}