part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitialState;
  const factory AuthState.loading() = AuthLoadingState;
  const factory AuthState.inputPincode() = AuthInputPincodeState;
  const factory AuthState.inputEmail() = AuthInputEmailState;
  const factory AuthState.errorPincode() = AuthErrorPincodeState;
  const factory AuthState.failed({required Exception exception}) =
      AuthErrorState;
  const factory AuthState.unauthorized() = AuthUnauthorizedState;
  const factory AuthState.authorized({required User user}) =
      AuthAuthorizedState;
}
