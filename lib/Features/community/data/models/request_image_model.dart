class RequestImageModel {
  final int id;
  final String image;

  RequestImageModel({required this.id, required this.image});

  factory RequestImageModel.fromJson(Map<String, dynamic> json) {
    return RequestImageModel(
      id: json['id'] as int? ?? 0,
      image: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'image': image};
  }
}
