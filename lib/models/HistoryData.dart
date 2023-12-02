class HistoryData {
  int? length;
  List<dynamic> time;
  List<dynamic> count;

  HistoryData({required this.length, required this.time, required this.count});

  // Named constructor for creating an instance with default values
  HistoryData.defaultValues()
      : length = 0,
        time = [],
        count = [];

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      length: int.tryParse(json['length']) ?? 0,
      time: json['time'],
      count: json['count'],
    );
  }
}