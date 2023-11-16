part of 'report_user_cubit.dart';

@freezed
class ReportUserState with _$ReportUserState {
  const factory ReportUserState.initial() = _Initial;
  const factory ReportUserState.loading() = Loading;
  const factory ReportUserState.errorState(
      {required AppException appException}) = ErrorState;
  const factory ReportUserState.successState() = SuccessState;
}
