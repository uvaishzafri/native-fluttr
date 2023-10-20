part of 'notification_cubit.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = Initial;
  const factory NotificationState.loading() = Loading;
  const factory NotificationState.errorState({required AppException appException}) = ErrorState;
  const factory NotificationState.successState({required List<AppNotification> notifications}) = SuccessState;
}
