class CarModel {
  final int id;
  final String brand;
  final String model;
  final int year;
  final String plateNumber;
  final String color;
  final String createdAt;
  final String updatedAt;

  CarModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.plateNumber,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      brand: json['brand']?.toString() ?? '',
      model: json['model']?.toString() ?? '',
      year: json['year'] is int
          ? json['year']
          : int.tryParse(json['year']?.toString() ?? '') ?? 0,
      plateNumber: json['plate_number']?.toString() ?? '',
      color: json['color']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'year': year,
      'plate_number': plateNumber,
      'color': color,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  Map<String, dynamic> toJsonForSave() {
    return {
      'brand': brand,
      'model': model,
      'year': year,
      'plate_number': plateNumber,
      'color': color,
    };
  }
}
