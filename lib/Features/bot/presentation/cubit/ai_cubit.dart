import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:motoverse/Features/bot/data/models/ai_explaination_response_model.dart';
import 'package:motoverse/Features/bot/data/models/ai_obd_diagnosis_response_model.dart';
import 'package:motoverse/Features/bot/domain/repo/ai_repo.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  final AiRepo aiRepo;
  AiCubit({required this.aiRepo}) : super(AiInitial());

  Future<void> sendChatMessage({required String messageText}) async {
    emit(AiChatLoading(userMessage: messageText));

    final result = await aiRepo.getChatDiagnosis(message: messageText);

    result.fold(
      (failure) {
        debugPrint('failure: ${failure.errorMsg}');
         emit(AiChatFailure(errMessage: failure.errorMsg));},
      (aiResponseModel) {
        debugPrint('successsss');
        emit(
          AiChatSuccess(userMessage: messageText, aiResponse: aiResponseModel),
        );
      },
    );
  }

  Future<void> sendObdDiagnosis({required Map<String, dynamic> body}) async {
    emit(AiObdLoading());

    final result = await aiRepo.getObdDiagnosis(body: body);

    result.fold(
      (failure) {
        debugPrint('OBD failure: ${failure.errorMsg}');
        emit(AiObdFailure(errMessage: failure.errorMsg));
      },
      (obdResponseModel) {
        debugPrint('OBD successsss');
        emit(AiObdSuccess(obdResponse: obdResponseModel, body: body));
      },
    );
  }
}
