import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/model/likes_model.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';

part 'likes_state.dart';
part 'likes_cubit.freezed.dart';

@lazySingleton
class LikesCubit extends Cubit<LikesState> {
  LikesCubit(this._userRepository) : super(const LikesState.initial());

  final UserRepository _userRepository;

  requestMatch(String userId) async {
    emit(const LikesState.loading());

    var requestRep = await _userRepository.requestMatch(userId);
    requestRep.fold(
      (left) => emit(LikesState.errorState(appException: left)),
      (right) => emit(const LikesState.requestMatchSuccess()),
    );
  }

  fetchLikesReport() async {
    emit(const LikesState.loading());

    var notificationsList = await _userRepository.getLikesReport();
    notificationsList.fold(
      (left) => emit(LikesState.errorState(appException: left)),
      (right) => emit(LikesState.successState(likes: right)),
    );
  }
}
