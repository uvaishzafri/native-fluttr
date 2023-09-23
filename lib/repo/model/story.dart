import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/util/datetime_serializer.dart';

part 'story.freezed.dart';
part 'story.g.dart';

@freezed
class Story with _$Story {
  const factory Story({
    required int id,
    required int score,
    @DatetimeSerializer() required DateTime time,
    required String title,
    required String type,
    @Default('') String url,
    @Default('') String text,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}

extension StoryExt on Story {
  bool get isAsk => url.isEmpty && text.isNotEmpty;
}
