import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motoverse/Core/errors/failure.dart';

class FirebaseAuthService {
  Future<Either<Failure, void>> login(String token) async {
    try {
      await FirebaseAuth.instance.signInWithCustomToken(token);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(Failure(errorMsg: e.message!));
    } catch (e) {
      return left(Failure(errorMsg: e.toString()));
    }
  }

}

