import 'package:get/get.dart';

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


