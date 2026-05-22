import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserDataModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String phone;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final bool isPhoneVerified;
  @HiveField(5)
  final bool isProfileComplete;
  @HiveField(6)
  final String? city;
  @HiveField(7)
  final bool isVerified;
  @HiveField(8)
  final String image;

  UserDataModel({
    required this.id,
    required this.phone,
    required this.name,
    required this.email,
    required this.isPhoneVerified,
    required this.isProfileComplete,
    required this.isVerified,
    required this.image,
    this.city,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      email: json['email'],
      isPhoneVerified: json['is_phone_verified'],
      isProfileComplete: json['is_profile_complete'],
      city: json['city']??"",
      isVerified: json['is_verified'],
      image: json['image']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
      'email': email,
      'is_phone_verified': isPhoneVerified,
      'is_profile_complete': isProfileComplete,
      'city': city,
      'is_verified': isVerified,
      'image': image,
    };
  }
}
