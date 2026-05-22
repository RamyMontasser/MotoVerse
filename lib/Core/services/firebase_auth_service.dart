// import 'package:dartz/dartz.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:motoverse/Core/errors/failure.dart';

// class FirebaseAuthService {
//   Future<Either<Failure, void>> login(String token) async {
//     try {
//       await FirebaseAuth.instance.signInWithCustomToken(token);
//       return right(null);
//     } on FirebaseAuthException catch (e) {
//       if(e.code == 'invalid-credential'){
//         return left(ServerFailure(errorMsg: 'Invalid Credentials'));
//       }else if(e.code == 'credential-already-in-use'){
//         return left(ServerFailure(errorMsg: 'Credential Already In Use'));
//       }
//       return left(ServerFailure(errorMsg: e.message!));
//     } catch (e) {
//       return left(ServerFailure(errorMsg: e.toString()));
//     }
//   }

// }

