class DateFormatter {
  static DateTime formatJsonDateString(String jsonDate) =>
      DateTime.parse(jsonDate.substring(0, jsonDate.indexOf('Z') - 1));
}
