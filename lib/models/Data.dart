import 'package:get/get.dart';

// class Data {
//   DataNow dataNow;
//
//   Data({required this.dataNow});
//
//   Data.defaultValues()
//       : dataNow = DataNow(count: 0, dateTime: DateTime.now());
// }

class DataNow {
  int personCount;
  DateTime dateTime;

  DataNow({required this.personCount, required this.dateTime});

  DataNow.defaultValues()
      : personCount = 0,
        dateTime = DateTime.now();
}

class DataPoke {
  int count;

  DataPoke({required this.count});

  DataPoke.defaultValues()
      : count = 0;

}


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
//
class HistoryData {
  int length;
  List<DateTime> time;
  List<int> count;

  HistoryData({required this.length, required this.time, required this.count});

  // Named constructor for creating an instance with default values
  HistoryData.defaultValues()
      : length = 0,
        time = [],
        count = [];
}
