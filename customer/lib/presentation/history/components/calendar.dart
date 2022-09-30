import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CalendarShift{

  Future<DateTime?> calender(context) async {
    return DatePicker.showDatePicker(
        context,
        showTitleActions: true,
        minTime: DateTime(2018, 3, 5),
        maxTime: DateTime(2019, 6, 7),
        currentTime: DateTime.now(), locale: LocaleType.en);
  }
}