// -- user_account.dart --
import 'dart:convert';

UserAccount userAccountFromJson(String str) => UserAccount.fromJson(json.decode(str));
List<UserAccount> userAccountListFromJson(String str) {
  final parsed = json.decode(str).cast<Map<String, dynamic>>();
  return parsed.map<UserAccount>((json) => UserAccount.fromJson(json)).toList();
}
String? userAccountToJson(UserAccount data) => json.encode(data.toJson());

class UserAccount {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? isApproved;

  UserAccount({this.id, this.name, this.email, this.password,this.isApproved = false,});

  factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
      id: json['id'],
      name:json['name'],
      email: json['email'],
      password: json['password'],
      isApproved: json['isApproved'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name":name,
    "email": email,
    "password": password,
    "isApproved": isApproved,
  };
}
