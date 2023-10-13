import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/util/app_constants.dart';

class DatetimeSerializer implements JsonConverter<DateTime, dynamic> {
  const DatetimeSerializer();

  @override
  DateTime fromJson(dynamic timestamp) =>
      DateTime.fromMillisecondsSinceEpoch((timestamp as int) * 1000);

  @override
  int toJson(DateTime date) => (date.millisecondsSinceEpoch / 1000) as int;
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

// class GenderConverter implements JsonConverter<Gender?, String?> {
//   const GenderConverter();

//   @override
//   Gender? fromJson(String? gender) {
//     return Gender.values.cast<Gender?>().firstWhere((e) => e?.name == gender?.toLowerCase(), orElse: () => null);
//   }

//   @override
//   String? toJson(Gender? gender) => gender?.name.toUpperCase();
// }
