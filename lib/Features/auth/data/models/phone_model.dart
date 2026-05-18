import 'package:motoverse/Features/auth/domain/entities/phone_entity.dart';

class PhoneModel {
  final String verificationToken;
  final bool isNewUser;
  final String detail;
  final bool isProfileComplete;

  PhoneModel({
    required this.verificationToken,
    required this.isNewUser,
    required this.detail,
    required this.isProfileComplete,
  });

  factory PhoneModel.fromjson(Map<String, dynamic> data) {
    return PhoneModel(
      verificationToken: data['verification_token'] ?? "",
      isNewUser: data['is_new_user'] ?? true,
      detail: data['detail'] ?? "",
      isProfileComplete: data['is_profile_complete'] ?? false,
    );
  }

  PhoneEntity toEntity() {
    return PhoneEntity(
      verificationToken: verificationToken,
      detail: detail,
      isProfileComplete: isProfileComplete,
    );
  }

  // factory PhoneModel.fromEntity(PhoneEntity phoneEntity) {
  //   return PhoneModel(
  //     verificationToken: userverificationToken,
  //     isNewUser: isNewUser,
  //     detail: detail,
  //     isProfileComplete: isProfileComplete,
  //   );
  // }
}
