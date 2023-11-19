part of 'edit_profile_cubit.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.initial() = EditProfileInitialState;
  const factory EditProfileState.loading() = EditProfileLoadingState;
  const factory EditProfileState.error({required AppException appException}) =
      EditProfilErrorState;
  const factory EditProfileState.success({required User user}) =
      EditProfileSuccessState;
}
