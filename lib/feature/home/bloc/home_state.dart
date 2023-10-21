part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeInitialState;
  const factory HomeState.loading() = HomeLoadingState;
  const factory HomeState.error({required AppException appException}) = HomeErrorState;
  const factory HomeState.success({required List<User> users}) = HomeSuccessState;
  const factory HomeState.requestMatchSuccess() = HomeRequestMatchSuccessState;
}
