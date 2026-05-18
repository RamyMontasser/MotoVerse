import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:motoverse/Core/constants/constants.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Core/services/network_service.dart';
import 'package:motoverse/Features/history/data/models/car_history_model.dart';
import 'package:motoverse/Features/history/data/models/history_summary_model.dart';
import 'package:motoverse/Features/history/domain/repo/history_repo.dart';

class HistoryRepoImp implements HistoryRepo {
  final NetworkService networkService;

  HistoryRepoImp({required this.networkService});

  @override
  Future<Either<Failure, List<CarHistoryModel>>> getCarHistory() async {
    try {
      final response = await networkService.getData(
        endPoint: AppConstants.carHistory,
      );

      List<CarHistoryModel> history = [];
      if (response is List) {
        history = response.map((e) => CarHistoryModel.fromJson(e)).toList();
      }

      return Right(history);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HistorySummaryModel>> getHistorySummary() async {
    try {
      final response = await networkService.getData(
        endPoint: AppConstants.carHistorySummary,
      );

      return Right(HistorySummaryModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addHistory(CarHistoryModel history) async {
    try {
      await networkService.addData(
        endPoint: AppConstants.carHistory,
        data: history.toJson(),
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMsg: e.toString()));
    }
  }
}
