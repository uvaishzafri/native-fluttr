part of 'item_comment_cubit.dart';

@freezed
class ItemCommentState with _$ItemCommentState {
  const factory ItemCommentState.initial() = Initial;

  const factory ItemCommentState.loading() = Loading;

  const factory ItemCommentState.error({required AppException appException}) = Error;

  const factory ItemCommentState.success() = Success;
}
