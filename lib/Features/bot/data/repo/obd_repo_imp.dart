import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Features/bot/data/models/obd_analysis_model.dart';
import 'package:motoverse/Features/bot/domain/repo/obd_repo.dart';
import 'package:motoverse/Features/bot/presentation/widgets/obd/csv_simulator_helper.dart';

class ObdRepoImp implements ObdRepo {
  final NetworkService networkService;

  ObdRepoImp({required this.networkService});

  @override
  Future<Either<Failure, AiAnalysisModel>> getAiAnalysis({
    required PlatformFile file,
  }) async {
    try {
      // Get file bytes - try file.bytes first, then read from path
      List<int>? fileBytes = file.bytes;

      if (fileBytes == null || fileBytes.isEmpty) {
        if (file.path != null) {
          debugPrint('Bytes null, reading from path: ${file.path}');
          final fileFromPath = File(file.path!);
          if (await fileFromPath.exists()) {
            fileBytes = await fileFromPath.readAsBytes();
          }
        }
      }

      if (fileBytes == null || fileBytes.isEmpty) {
        debugPrint('File is empty or could not be read');
        return Left(
          ServerFailure(
            errorMsg: 'File is empty or could not be read. Path: ${file.path}',
          ),
        );
      }

      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(fileBytes, filename: file.name),
      });

      final response = await networkService.addFormData(
        endPoint: '/ai-assistant/obd-analysis/',
        data: formData,
        options: Options(
          sendTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 40),
        ),
      );

      if (response == null) {
        debugPrint('Response is null from server');
        return Left(ServerFailure(errorMsg: 'Empty response from server'));
      }

      if (response is! Map<String, dynamic>) {
        debugPrint('Response is not a Map: ${response.runtimeType}');
        return Left(
          ServerFailure(errorMsg: 'Invalid response format from server'),
        );
      }

      final analysisModel = AiAnalysisModel.fromJson(response);
      debugPrint('success from ai: $analysisModel');
      return Right(analysisModel);
    } on DioException catch (e) {
      debugPrint('error from dio: ${e.message}');
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      debugPrint('error from server: ${e.toString()}');
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Stream<Map<String, dynamic>> startObdSimulation(PlatformFile file) {
    final controller = StreamController<Map<String, dynamic>>();

    controller.onListen = () async {
      final csvRows = await CsvSimulatorHelper.parsePlatformFile(file);
      int index = 1;

      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (index >= csvRows.length) {
          timer.cancel();
          controller.close();
          return;
        }

        final row = csvRows[index];

        // String row[int idx, String fallback) {
        //   if (idx < 0 || idx >= row.length) return fallback;
        //   final val = row[idx]?.toString().trim() ?? fallback;
        //   return val.isEmpty ? fallback : val;
        // }

      //   controller.add({
      //     'carModel': '${row[1, '')} ${row[2, '')} ${row[3, '')}'
      //         .trim(),
      //     'fuel': row[4, '0'),    
      //     'intake': row[5, '0'),
      //     'baro': row[6, '0'),
      //     'runtime': row[7, '0'),
      //     'rpm': row[8, '0'),
      //     'speed': row[9, '0'),
      //     'temp': row[10, '0'),
      //     'load': row[12, '0'),
      //     'faultCode': row[13, ),
      //   });
      //   index++;
      // });
        controller.add({
          'carModel': '${row[1]} ${row[2]} ${row[3]}'
              .trim(),
          'fuel': row[4],    
          'intake': row[5],
          'baro': row[6],
          'runtime': row[7],
          'rpm': row[8],
          'speed': row[9],
          'temp': row[10],
          'load': row[12],
          'faultCode': row[13],
        });
        index++;
      });
    };

    return controller.stream;
  }
}
