String todayDateYYYYMMDD() {
  var date = DateTime.now();
  return createString(date);
}

DateTime createDateTime(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));

  return DateTime(yyyy, mm, dd);
}

String createString(DateTime date) {
  String year = date.year.toString();
  String month = date.month.toString();
  if (month.length == 1) {
    month = ("0$month");
  }
  String day = date.day.toString();
  if (day.length == 1) {
    day = ("0$day");
  }
  return year + month + day;
}