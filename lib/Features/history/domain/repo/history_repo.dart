import 'package:dartz/dartz.dart';
import 'package:motoverse/Core/errors/failure.dart';
import 'package:motoverse/Features/history/data/models/car_history_model.dart';
import 'package:motoverse/Features/history/data/models/history_summary_model.dart';

abstract class HistoryRepo {
  Future<Either<Failure, List<CarHistoryModel>>> getCarHistory();
  Future<Either<Failure, HistorySummaryModel>> getHistorySummary();
  Future<Either<Failure, void>> addHistory(CarHistoryModel history);
}
