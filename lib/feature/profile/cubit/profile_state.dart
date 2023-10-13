part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _loading;
  const factory ProfileState.userDetails({required User user}) = _userDetails;
  const factory ProfileState.profileUpdated() = _profileUpdated;
  const factory ProfileState.error({required AppException exception}) = _error;
}
