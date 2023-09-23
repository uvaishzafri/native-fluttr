part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeInitialState;
  const factory HomeState.loading() = HomeLoadingState;
}
