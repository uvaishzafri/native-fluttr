extension DateTimeExtension on DateTime {
  String ageFromDate() {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - year;
    int month1 = currentDate.month;
    int month2 = month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = day;
      if (day2 > day1) {
        age--;
      }
    }
    return '${age.toString()}yrs';
  }
}
