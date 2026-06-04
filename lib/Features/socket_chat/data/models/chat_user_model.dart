class ChatUserModel {
  final int id;
  final String name;
  final String? image;
  final bool isVerified;
  final bool isOnline;

  ChatUserModel({
    required this.id,
    required this.name,
    this.image,
    required this.isVerified,
    required this.isOnline,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id'].toString()) ?? 0,
      name: (json['name'] ?? '').toString(),
      image: _parseStringOrMapUrl(json['image']),
      isVerified: json['is_verified'] is bool
          ? json['is_verified'] as bool
          : (json['is_verified']?.toString().toLowerCase() == 'true'),
      isOnline: json['is_online'] is bool
          ? json['is_online'] as bool
          : (json['is_online']?.toString().toLowerCase() == 'true'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'is_verified': isVerified,
      'is_online': isOnline,
    };
  }
}

String? _parseStringOrMapUrl(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is Map) {
    return value['url']?.toString() ??
        value['path']?.toString() ??
        value['link']?.toString() ??
        value['file']?.toString() ??
        value['image']?.toString();
  }
  return value.toString();
}
