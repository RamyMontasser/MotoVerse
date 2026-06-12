class AiExplainationResponseModel {
  final String sessionId;
  final String mode;
  final AiResponseData aiResponse;
  final bool followUpEnabled;

  AiExplainationResponseModel({
    required this.sessionId,
    required this.mode,
    required this.aiResponse,
    required this.followUpEnabled,
  });

  factory AiExplainationResponseModel.fromJson(Map<String, dynamic> json) {
    return AiExplainationResponseModel(
      sessionId: json['session_id'] ?? '',
      mode: json['mode'] ?? '',
      aiResponse: AiResponseData.fromJson(json['ai_response'] ?? {}),
      followUpEnabled: json['follow_up_enabled'] ?? false,
    );
  }
}

class AiResponseData {
  final String problemSummary;
  final Severity severity;
  final List<String> possibleCauses;
  final List<String> whatToCheck;
  final bool canCheckAtHome;
  final String recommendation;

  AiResponseData({
    required this.problemSummary,
    required this.severity,
    required this.possibleCauses,
    required this.whatToCheck,
    required this.canCheckAtHome,
    required this.recommendation,
  });

  factory AiResponseData.fromJson(Map<String, dynamic> json) {
    return AiResponseData(
      problemSummary: json['problem_summary'] ?? '',
      severity: Severity.fromJson(json['severity'] ?? {}),
      possibleCauses: List<String>.from(json['possible_causes'] ?? []),
      whatToCheck: List<String>.from(json['what_to_check'] ?? []),
      canCheckAtHome: json['can_check_at_home'] ?? false,
      recommendation: json['recommendation'] ?? '',
    );
  }
}

class Severity {
  final String level;
  final String canDrive;

  Severity({required this.level, required this.canDrive});

  factory Severity.fromJson(Map<String, dynamic> json) {
    return Severity(
      level: json['level'] ?? '',
      canDrive: json['can_drive'] ?? '',
    );
  }
}
