part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitialState;
  const factory AuthState.loading() = AuthLoadingState;
  const factory AuthState.inputPincode() = AuthInputPincodeState;
  const factory AuthState.inputEmail() = AuthInputEmailState;
  const factory AuthState.emailVerificationSent() = AuthEmailVerificationSentState;
  const factory AuthState.emailVerificationComplete() = AuthEmailVerificationCompleteState;
  const factory AuthState.errorPincode({required AppException exception}) = AuthErrorPincodeState;
  const factory AuthState.failed({required AppException exception}) =
      AuthErrorState;
  const factory AuthState.emailSendFailed({required AppException exception}) = AuthEmailSendFailedState;
  const factory AuthState.unauthorized() = AuthUnauthorizedState;
  const factory AuthState.createProfile() = AuthCreateProfileState;
  const factory AuthState.authorized({required User user}) =
      AuthAuthorizedState;
}
