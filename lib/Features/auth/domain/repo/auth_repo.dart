import 'package:dartz/dartz.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Features/auth/domain/entities/phone_entity.dart';
import 'package:motoverse/Features/auth/domain/entities/tokens_entity.dart';
import 'package:motoverse/Features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, dynamic>> sendOTP({required String phone});

  Future<Either<Failure, PhoneEntity>> verifyOTP({
    required String phone,
    required String code,
  });

  Future<Either<Failure, dynamic>> complete({
    required UserEntity userEntity,
    required String verifyToken,
  });

  Future<Either<Failure, TokensEntity>> logIn({
    required String email,
    required String pass,
  });

  Future<Either<Failure, dynamic>> restorePassRequest({required String phone});

  Future<Either<Failure, Map<String, dynamic>>> verifyResetPass({
    required String phoneNum,
    required String code,
  });

  Future<Either<Failure, Map<String, dynamic>>> confirmResetPass({
    required String resetToken,
    required String password,
  });

  Future<void> logOut();

  Future<Either<Failure, dynamic>> deleteAccount();
}
