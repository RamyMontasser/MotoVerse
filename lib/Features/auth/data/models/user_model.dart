import 'package:motoverse/Features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String name;
  final String email;
  final String password;
  // final String access;
  // final String refresh;
  // final Map<String, String> expiredAt;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    // required this.access,
    // required this.refresh,
    // required this.expiredAt,
  });

  factory UserModel.fromjson(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'],
      email: data['email'],
      password: data['password'],
      //   access: data['name'],
      //   refresh: data['name'],
      //   expiredAt: data['name'],
    );
  }
  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      name: userEntity.name,
      email: userEntity.email,
      password: userEntity.password,
    );
  }

  UserEntity toEntity() {
    return UserEntity(name: name, email: email, password: password);
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'password': password};
  }
}
