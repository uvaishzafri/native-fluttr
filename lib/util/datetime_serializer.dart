import 'package:freezed_annotation/freezed_annotation.dart';

class DatetimeSerializer implements JsonConverter<DateTime, dynamic> {
  const DatetimeSerializer();

  @override
  DateTime fromJson(dynamic timestamp) =>
      DateTime.fromMillisecondsSinceEpoch((timestamp as int) * 1000);

  @override
  int toJson(DateTime date) => (date.millisecondsSinceEpoch / 1000) as int;
}
