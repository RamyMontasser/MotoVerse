import 'package:flutter/material.dart';
import 'package:motoverse/Core/theme/app_colors.dart';

class NotificationModel {
  final int id;
  final String notificationType;
  final String title;
  final String body;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.notificationType,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      notificationType: json['notification_type'] ?? 'welcome',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

extension NotificationTypeDetails on NotificationModel {
  IconData get icon {
    switch (notificationType) {
      case 'welcome':
        return Icons.check_circle_rounded;
      case 'offer_accepted':
        return Icons.check_circle_outline;
      case 'offer':
        return Icons.local_offer_outlined;
      case 'offer_rejected':
        return Icons.cancel_outlined;
      case 'chat':
        return Icons.chat_outlined;
      case 'verification':
        return Icons.verified_user_outlined;
      default:
        return Icons.notifications_none;
    }
  }

  Color get iconColor {
    switch (notificationType) {
      case 'welcome':
        return AppColors.yellowNormal;
      case 'offer_accepted':
        return AppColors.greenNormal;
      case 'offer':
        return AppColors.blueNormal;
      case 'chat':
        return AppColors.yellowNormal;
      case 'verification':
        return AppColors.greenNormal;
      case 'offer_rejected':
        return AppColors.redNormal;
      default:
        return AppColors.blueNormal;
    }
  }

  Color get backgroundColor {
    switch (notificationType) {
      case 'welcome':
        return AppColors.yellowLight;
      case 'offer_accepted':
        return AppColors.greenLight;
      case 'offer':
        return AppColors.blueLight;
      case 'chat':
        return AppColors.yellowLight;
      case 'verification':
        return AppColors.greenLight;
      case 'offer_rejected':
        return AppColors.redLight;
      default:
        return AppColors.blueLight;
    }
  }
}
