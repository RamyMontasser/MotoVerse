class CarHistoryModel {
  final String centerName;
  final String service;
  final String description;
  final String date;
  // final String time;
  final String cost;
  // final String reading;

  CarHistoryModel({
    required this.centerName,
    required this.service,
    required this.description,
    required this.date,
    // required this.time,
    required this.cost,
    // required this.reading,
  });

  factory CarHistoryModel.fromJson(Map<String, dynamic> json) {
    return CarHistoryModel(
      centerName: json['center_name'] ?? '',
      service: json['service'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      // time: json['time'] ?? '',
      cost: json['cost'] ?? '',
      // reading: json['reading'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'center_name': centerName,
      'service': service,
      'description': description,
      'date': date,
      // 'time': time,
      'cost': cost,
      // 'reading': reading,
    };
  }
}
