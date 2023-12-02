import 'package:flutter_halte/models/HistoryData.dart';

class History {
  HistoryData oneHour;
  HistoryData threeHour;
  HistoryData sixHour;
  HistoryData twelveHour;
  HistoryData oneDay;
  HistoryData threeDay;
  HistoryData sevenDay;

  History({
    required this.oneHour,
    required this.threeHour,
    required this.sixHour,
    required this.twelveHour,
    required this.oneDay,
    required this.threeDay,
    required this.sevenDay,
  });

  // Named constructor for creating an instance with default values
  History.defaultValues()
      : oneHour = HistoryData.defaultValues(),
        threeHour = HistoryData.defaultValues(),
        sixHour = HistoryData.defaultValues(),
        twelveHour = HistoryData.defaultValues(),
        oneDay = HistoryData.defaultValues(),
        threeDay = HistoryData.defaultValues(),
        sevenDay = HistoryData.defaultValues();
}