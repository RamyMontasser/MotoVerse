import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Features/bot/data/models/ai_explaination_response_model.dart';
import 'package:motoverse/Features/bot/data/models/ai_obd_diagnosis_response_model.dart';
import 'package:motoverse/Features/bot/domain/repo/ai_repo.dart';

class AiRepoImp implements AiRepo {
  final NetworkService networkService;

  AiRepoImp({required this.networkService});
  @override
  Future<Either<Failure, AiExplainationResponseModel>> getChatDiagnosis({
    required String message,
  }) async {
    try {
      final response = await networkService.addData(
        endPoint: '/ai-assistant/chat-diagnosis/',
        data: {'message': message},
        options: Options(
          sendTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 40),
        ),
      );

      final diagnosisModel = AiExplainationResponseModel.fromJson(
        response,
      );
      return Right(diagnosisModel);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AiObdDiagnosisResponseModel>> getObdDiagnosis({
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await networkService.addData(
        endPoint: '/ai-assistant/obd-diagnosis/',
        data: body,
        options: Options(
          sendTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 40),
        ),
      );

      final obdModel = AiObdDiagnosisResponseModel.fromJson(response);
      return Right(obdModel);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }
}
