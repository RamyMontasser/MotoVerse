import 'package:motoverse/Features/bot/data/models/ai_explaination_response_model.dart';

class AiObdDiagnosisResponseModel {
  final String? code;
  final String? description;
  final int? severityScore;
  final AiResponseData? aiResponse;

  AiObdDiagnosisResponseModel({
    required this.code,
    required this.description,
    required this.severityScore,
    required this.aiResponse,
  });

  factory AiObdDiagnosisResponseModel.fromJson(Map<String, dynamic> json) {
    final resultsList = json['results'] as List<dynamic>?;

    final firstResult = (resultsList != null && resultsList.isNotEmpty)
        ? resultsList.first as Map<String, dynamic>
        : null;

    return AiObdDiagnosisResponseModel(
      code: firstResult?['code'] as String?,
      description: firstResult?['description'] as String?,
      severityScore: firstResult?['severity_score'] as int?,
      aiResponse: firstResult?['ai_response'] != null
          ? AiResponseData.fromJson(
              firstResult!['ai_response'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  // final List<ObdResult>? results;

  // AiObdDiagnosisResponseModel({this.results});

  // factory AiObdDiagnosisResponseModel.fromJson(Map<String, dynamic> json) {
  //   return AiObdDiagnosisResponseModel(
  //     results: (json['results'] as List<dynamic>?)
  //         ?.map((e) => ObdResult.fromJson(e as Map<String, dynamic>))
  //         .toList(),
  //   );
  // }

  // // Map<String, dynamic> toJson() {
  // //   return {'results': results?.map((e) => e.toJson()).toList()};
  // // }
}

// class ObdResult {
//   final String? code;
//   final String? description;
//   final int? severityScore;
//   final AiResponseData? aiResponse;

//   ObdResult({this.code, this.description, this.severityScore, this.aiResponse});

//   factory ObdResult.fromJson(Map<String, dynamic> json) {
//     return ObdResult(
//       code: json['code'] as String?,
//       description: json['description'] as String?,
//       severityScore: json['severity_score'] as int?,
//       aiResponse: json['ai_response'] != null
//           ? AiResponseData.fromJson(json['ai_response'] as Map<String, dynamic>)
//           : null,
//     );
//   }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'code': code,
  //     'description': description,
  //     'severity_score': severityScore,
  //     'ai_response': aiResponse?.toJson(),
  //   };
  // }
// }
