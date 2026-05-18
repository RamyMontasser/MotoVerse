class CreateHistoryModel {
  final String date;
  final String service;
  final String description;
  final String cost;
  final String reading;

  CreateHistoryModel({
    required this.date,
    required this.service,
    required this.description,
    required this.cost,
    required this.reading,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'service': service,
      'description': description,
      'cost': cost,
      'reading': reading,
    };
  }
}
