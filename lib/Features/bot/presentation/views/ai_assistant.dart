import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motoverse/Core/services/getit.dart';
import 'package:motoverse/Core/theme/app_colors.dart';
import 'package:motoverse/Core/theme/text_styles.dart'; // استيراد الـ Styles
import 'package:motoverse/Core/widgets/custom_scrollview_with_appbar.dart';
import 'package:motoverse/Features/bot/domain/repo/ai_repo.dart';
import 'package:motoverse/Features/bot/presentation/cubit/ai_cubit.dart';
import 'package:motoverse/Features/bot/presentation/widgets/chat_response.dart';
import 'package:motoverse/Features/bot/presentation/widgets/message.dart';
import 'package:motoverse/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AiAssistant extends StatefulWidget {
  const AiAssistant({super.key});

  @override
  State<AiAssistant> createState() => _AiAssistantState();
}

class _AiAssistantState extends State<AiAssistant> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiCubit(aiRepo: getIt<AiRepo>()),
      child: Builder(
        builder: (innerContext) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final arguments = ModalRoute.of(context)?.settings.arguments;

            if (arguments != null &&
                innerContext.read<AiCubit>().state is AiInitial) {
              if (arguments is String && arguments.isNotEmpty) {
                innerContext.read<AiCubit>().sendChatMessage(
                  messageText: arguments,
                );
              } else if (arguments is Map<String, dynamic>) {
                innerContext.read<AiCubit>().sendObdDiagnosis(body: arguments);
              }
            }
          });

          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Column(
              children: [
                Expanded(
                  child: CustomScrollViewWithAppBar(
                    controller: _scrollController,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: BlocBuilder<AiCubit, AiState>(
                        builder: (context, state) {
                          if (state is AiChatLoading) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Message(messageContent: state.userMessage),
                                SizedBox(height: 20.h),
                                Skeletonizer(
                                  child: ChatResponse(
                                    userMessage: '',
                                    problemSummary: '',
                                    severityLevel: '',
                                    canDrive: '',
                                    possibleCauses: [],
                                    whatToCheck: [],
                                    canCheckAtHome: false,
                                    recommendation: '',
                                  ),
                                ),
                              ],
                            );
                          }

                          if (state is AiChatSuccess) {
                            return ChatResponse(
                              userMessage: state.userMessage,
                              problemSummary:
                                  state.aiResponse.aiResponse.problemSummary,
                              severityLevel:
                                  state.aiResponse.aiResponse.severity.level,
                              canDrive:
                                  state.aiResponse.aiResponse.severity.canDrive,
                              possibleCauses:
                                  state.aiResponse.aiResponse.possibleCauses,
                              whatToCheck:
                                  state.aiResponse.aiResponse.whatToCheck,
                              canCheckAtHome:
                                  state.aiResponse.aiResponse.canCheckAtHome,
                              recommendation:
                                  state.aiResponse.aiResponse.recommendation,
                            );
                          }

                          if (state is AiChatFailure) {
                            return _buildFailureWidget(state.errMessage);
                          }

                          if (state is AiObdLoading) {
                            return Skeletonizer(
                              child: ChatResponse(
                                userMessage: '',
                                problemSummary: 'نص وهمي للتحميل فقط...',
                                severityLevel: 'متوسط',
                                canDrive: 'نعم',
                                possibleCauses: const ['سبب أول', 'سبب ثانِ'],
                                whatToCheck: const ['فحص أول'],
                                canCheckAtHome: true,
                                recommendation:
                                    'توصية فنية وهمية للـ Skeleton...',
                              ),
                            );
                          }

                          if (state is AiObdSuccess) {
                            final obdData = state.obdResponse;

                            if (obdData.code == null) {
                              return _buildFailureWidget(
                                S.of(context).noDiagnosticsFound,
                              );
                            }

                            return ChatResponse(
                              userMessage: '',
                              code: obdData.code,
                              description: obdData.description,
                              problemSummary:
                                  obdData.aiResponse?.problemSummary ?? '',
                              severityLevel:
                                  obdData.aiResponse?.severity.level ?? '',
                              canDrive:
                                  obdData.aiResponse?.severity.canDrive ?? '',
                              possibleCauses:
                                  obdData.aiResponse?.possibleCauses ?? [],
                              whatToCheck:
                                  obdData.aiResponse?.whatToCheck ?? [],
                              canCheckAtHome:
                                  obdData.aiResponse?.canCheckAtHome ?? false,
                              recommendation:
                                  obdData.aiResponse?.recommendation ?? '',
                            );
                          }

                          if (state is AiObdFailure) {
                            return _buildFailureWidget(state.errMessage);
                          }

                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFailureWidget(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyles.cairoBold14.copyWith(color: AppColors.redNormal),
        ),
      ),
    );
  }
}
