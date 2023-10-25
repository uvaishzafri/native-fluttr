part of 'block_user_cubit.dart';

@freezed
class BlockUserState with _$BlockUserState {
  const factory BlockUserState.initial() = Initial;
  const factory BlockUserState.loading() = Loading;
  const factory BlockUserState.errorState({required AppException appException}) = ErrorState;
  const factory BlockUserState.successState() = SuccessState;
}
