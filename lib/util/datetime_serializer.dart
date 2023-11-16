import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/model/native_type.dart';

class DatetimeSerializer implements JsonConverter<DateTime?, dynamic> {
  const DatetimeSerializer();

  @override
  DateTime? fromJson(dynamic timestamp) => timestamp == null
      ? null
      : DateTime.fromMillisecondsSinceEpoch((timestamp as int));

  @override
  int? toJson(DateTime? date) =>
      date == null ? null : (date.millisecondsSinceEpoch);
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

class TypeConverter implements JsonConverter<NativeTypeEnum?, Map?> {
  const TypeConverter();

  @override
  NativeTypeEnum? fromJson(Map? type) {
    return NativeTypeEnum.values.cast<NativeTypeEnum?>().firstWhere(
          (element) => element!.name.toLowerCase() == type?['en'].toLowerCase(),
          orElse: () => null,
        );
    // return Gender.values.cast<Gender?>().firstWhere((e) => e?.name == gender?.toLowerCase(), orElse: () => null);
  }

  @override
  Map? toJson(NativeTypeEnum? nativeTypeEnum) =>
      nativeTypeEnum == null ? null : {'en': nativeTypeEnum.name};
}
