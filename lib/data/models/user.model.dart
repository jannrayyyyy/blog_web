import 'package:blog_web/domain/entities/user.entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.password,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      createdAt: json['createdAt'],
    );
  }
}
