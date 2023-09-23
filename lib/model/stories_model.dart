import 'package:freezed_annotation/freezed_annotation.dart';

part 'stories_model.freezed.dart';

@freezed
class StoriesModel with _$StoriesModel {
  static int pageSize = 20;
  static int maxItems = 200;

  const factory StoriesModel({
    required int pageIndex,
    required List<int> storyIds,
  }) = _StoriesModel;

  factory StoriesModel.initial(List<int> storyIds) => _StoriesModel(
        pageIndex: 0,
        storyIds: storyIds,
      );
}

extension StoriesModelExt on StoriesModel {
  StoriesModel next() =>
      (StoriesModel.maxItems / StoriesModel.pageSize) > pageIndex
          ? copyWith(
              pageIndex:
                  (StoriesModel.maxItems / StoriesModel.pageSize) > pageIndex
                      ? pageIndex + 1
                      : pageIndex,
            )
          : this;

  bool get isLastPage =>
      (StoriesModel.maxItems / StoriesModel.pageSize) <= pageIndex;
}
