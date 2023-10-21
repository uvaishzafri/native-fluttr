part of 'likes_cubit.dart';

@freezed
class LikesState with _$LikesState {
  const factory LikesState.initial() = Initial;
  const factory LikesState.loading() = Loading;
  const factory LikesState.errorState({required AppException appException}) = ErrorState;
  const factory LikesState.successState({required LikesModel likes}) = SuccessState;
}
