import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/model/app_notification.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';

part 'notification_state.dart';
part 'notification_cubit.freezed.dart';

@lazySingleton
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.userRepository) : super(const NotificationState.initial());

  final UserRepository userRepository;

  fetchNotifications() async {
    emit(const NotificationState.loading());

    var notificationsList = await userRepository.getCurrentUserNotifications();
    notificationsList.fold(
      (left) => emit(NotificationState.errorState(appException: left)),
      (right) => emit(NotificationState.successState(notifications: right)),
    );
  }
}
