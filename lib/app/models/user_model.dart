import 'package:getx_pattern_starter/app/common/utils.dart';

class UserModel {
  String? username;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? password;
  String? avatar;
  String? token;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? uid;
  String? gender;

  int? totalTransactionAmount;
  int? totalCoinEarned;
  UserModel({
    this.uid,
    this.username,
    this.name,
    this.avatar,
    this.phone,
    this.email,
    this.password,
    this.address,
    this.gender,
    this.createdAt,
    this.token,
    this.totalTransactionAmount,
    this.totalCoinEarned,
    this.updatedAt,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    avatar = json['avatar'] ?? '';
    address = json['address'] ?? '';
    gender = json['gender'] ?? '';
    // createdAt = json['createdAt'] ?? '';
    token = json['token'] ?? '';
    totalTransactionAmount = json['totalTransactionAmount'] ?? 0;
  }
  //tojson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['address'] = address;
    data['gender'] = gender;
    return data;
  }

  //make copy of this object
  UserModel copyWith(
      {String? uid,
      String? username,
      String? name,
      String? email,
      String? address,
      String? phone,
      String? avatar,
      String? token,
      String? role,
      String? createdAt,
      int? totalCoinEarned,
      int? totalTransactionAmount}) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      token: token ?? this.token,
      totalCoinEarned: totalCoinEarned ?? this.totalCoinEarned,
      totalTransactionAmount:
          totalTransactionAmount ?? this.totalTransactionAmount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String get transactionAmountString {
    return Utils.formatCurrency(totalTransactionAmount!.toDouble(),
        locale: 'id');
  }
}
