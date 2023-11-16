import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';

part 'report_user_state.dart';
part 'report_user_cubit.freezed.dart';

@lazySingleton
class ReportUserCubit extends Cubit<ReportUserState> {
  ReportUserCubit(this._userRepository)
      : super(const ReportUserState.initial());

  final UserRepository _userRepository;

  reportUser(String userId, String reasonCategory, String? reasonDesc) async {
    emit(const ReportUserState.loading());

    var notificationsList =
        await _userRepository.reportUser(userId, reasonCategory, reasonDesc);
    notificationsList.fold(
      (left) => emit(ReportUserState.errorState(appException: left)),
      (right) => emit(const ReportUserState.successState()),
    );
  }
}
