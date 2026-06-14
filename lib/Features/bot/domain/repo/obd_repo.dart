import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Features/bot/data/models/obd_analysis_model.dart';

abstract class ObdRepo {
  Stream<Map<String, dynamic>> startObdSimulation(PlatformFile file);

  Future<Either<Failure, AiAnalysisModel>> getAiAnalysis({
    required PlatformFile file,
  });
}
