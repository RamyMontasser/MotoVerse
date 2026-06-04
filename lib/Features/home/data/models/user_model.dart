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
  @HiveField(9)
  final String memberSince;

  UserDataModel({
    required this.id,
    required this.phone,
    required this.name,
    required this.email,
    required this.isPhoneVerified,
    required this.isProfileComplete,
    required this.isVerified,
    required this.memberSince,
    required this.image,
    this.city,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      phone: json['phone']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      isPhoneVerified: json['is_phone_verified'] is bool
          ? json['is_phone_verified']
          : json['is_phone_verified']?.toString().toLowerCase() == 'true',
      isProfileComplete: json['is_profile_complete'] is bool
          ? json['is_profile_complete']
          : json['is_profile_complete']?.toString().toLowerCase() == 'true',
      city: json['city']?.toString(),
      isVerified: json['is_verified'] is bool
          ? json['is_verified']
          : json['is_verified']?.toString().toLowerCase() == 'true',
      image: json['image']?.toString() ?? '',
      memberSince: json['member_since']?.toString() ?? '',
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
