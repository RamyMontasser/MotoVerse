import 'package:dartz/dartz.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Features/bot/data/models/ai_explaination_response_model.dart';
import 'package:motoverse/Features/bot/data/models/ai_obd_diagnosis_response_model.dart';

abstract class AiRepo {
  Future<Either<Failure, AiExplainationResponseModel>> getChatDiagnosis({
      required String message,
    });

    Future<Either<Failure, AiObdDiagnosisResponseModel>> getObdDiagnosis({
    required Map<String, dynamic> body,
  });
}